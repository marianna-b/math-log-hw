module FAApplyDeductionLib where

import FAProofCheckLib 
import Syntax
import qualified Data.Map.Strict as M
import FAModusPonens
import FASubstitutions
import AxiomCheck
import Debug.Trace

type ProofMap = M.Map String Proof

(~>) :: Expr -> Expr -> Expr
a ~> b = BinOp Impl a b

newProof :: ProofMap -> Context -> Expr -> Context -> Proof
newProof _ _ _ [] = []
newProof proofMap ctx a (x:xs) =
 let e = expr x in
 let fwd  = newProof proofMap ctx a xs in
  case reason x of
   Axiom _ ->  [e, subAx 1 [("A", e), ("B", a)], a ~> e] ++ fwd
   Assumption -> [e, subAx 1 [("A", e), ("B", a)], a ~> e] ++ fwd
   Alpha -> (getSelfImplProof a) ++ fwd
   MP q _ ->  (getMPProof a (expr (ctx !! (q - 1))) e) ++ fwd
   ExistsMP q -> (getExistsMPProof a proofMap (expr (ctx !! (q - 1))) e) ++ fwd
   ForallMP q -> (getForallMPProof a proofMap (expr (ctx !! (q - 1))) e) ++ fwd
   AxiomFA _  -> [e, subAx 1 [("A", e), ("B", a)], a ~> e] ++ fwd


substituteInProof :: Proof -> [(String, Expr)] -> Proof
substituteInProof [] _ = []
substituteInProof (x:xs) sub = (substitute x sub) : (substituteInProof xs sub)

getExistsMPProof :: Expr -> ProofMap -> Expr -> Expr -> Proof
getExistsMPProof a proofMap (BinOp Impl l r) (BinOp Impl x _) =
    let prf = (M.!) proofMap "exists" in
    let subPrf1 = substituteInProof prf [("A", a), ("B", l), ("C", r)] in
    let subPrf2 = substituteInProof prf [("A", x), ("B", a), ("C", r)] in
    let expr0 = l ~> (a ~> r) in
    let expr1 = x ~> (a ~> r) in
    let expr2 = a ~> (x ~> r) in
    subPrf1 ++ [expr0, expr1] ++ subPrf2 ++ [expr2]

getForallMPProof :: Expr -> ProofMap -> Expr -> Expr -> Proof
getForallMPProof a proofMap (BinOp Impl l r) (BinOp Impl _ y) =
    let prf1 = (M.!) proofMap "forall1" in
    let prf2 = (M.!) proofMap "forall2" in
    let subPrf1 = substituteInProof prf1 [("A", a), ("B", l), ("C", r)] in
    let subPrf2 = substituteInProof prf2 [("A", a), ("B", l), ("C", y)] in
    let expr0 = (BinOp And a l) ~> r in
    let expr1 = (BinOp And a l) ~> y in
    let expr2 = a ~> (l ~> y) in
    subPrf1 ++ [expr0, expr1] ++ subPrf2 ++ [expr2]


getMPProof :: Expr -> Expr -> Expr -> [Expr]
getMPProof a j i =
    let ax1 = subAx 2 [("A", a), ("B", j), ("C", i)] in
    let ax2 = modusPonensSub (a ~> j) ax1 in
    let ax3 = modusPonensSub (a ~> (j ~> i)) ax2 in
    [ax1, ax2, ax3]

getSelfImplProof :: Expr -> [Expr]
getSelfImplProof a =
  let ax1 = subAx 1 [("A", a), ("B", a)] in
  let ax2 = subAx 2 [("A", a), ("B", a ~> a), ("C", a)] in
  let ax3 = modusPonensSub ax1 ax2 in
  let ax4 = subAx 1 [("A", a), ("B", a ~> a)] in
  let ax5 = modusPonensSub ax4 ax3 in
  [ax1, ax2, ax3, ax4, ax5]

modusPonensSub :: Expr -> Expr -> Expr
modusPonensSub _ (BinOp Impl _ y) = y


subAx :: Int -> [(String, Expr)] -> Expr
subAx n subs = substitute (axioms !! (n - 1)) subs

substitute :: Expr -> [(String, Expr)] -> Expr
substitute e subs = case e of
  BinOp t a b -> BinOp t (substitute a subs) (substitute b subs)
  UnOp t a -> UnOp t (substitute a subs)
  PredicateSymb a [] -> case lookUpSub a subs of
                   Nothing -> PredicateSymb a []
                   Just s -> s

lookUpSub :: String -> [(String, Expr)] -> Maybe Expr
lookUpSub _ [] = Nothing
lookUpSub s ((a, b):xs) = if (a == s) then Just b
                          else lookUpSub s xs
--------------------------------------------------------------------
applyDeduct :: DeductionProof -> Context -> ProofMap -> DeductionProof
applyDeduct d ctx proofMap =
    let assump = assumption d in
    case assump of
      [] -> d
      _ -> let stmt = statement d in
           let assump2 = init $ assumption d in
           let alpha = last $ assump in
           let newPrf = newProof proofMap ctx alpha ctx in
           let newStmt = alpha ~> stmt in
           DeductionProof newStmt assump2 newPrf
