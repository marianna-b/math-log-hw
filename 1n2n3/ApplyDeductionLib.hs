module ApplyDeductionLib where

import Syntax
import ProofCheckerLib
import Debug.Trace
import qualified Data.Map.Strict as M

checkDeductProof :: Context -> Bool
checkDeductProof [] = True
checkDeductProof (x:xs) =
  if (reason x) == NoProof then
    False
  else
    checkDeductProof xs

getNewProof:: Expr -> [Expr] -> [Expr] -> Either String [Expr]
getNewProof a assump prf =
  let mps = MPsMap M.empty M.empty M.empty in
  let ctx = (getDeductCtx mps [] prf a assump) in
  if checkDeductProof ctx then
    Right $ reProofDeduct ctx a ctx
  else
    Left "Доказательство неверно"
--------------------------------------------------------------------
reProofDeduct :: Context -> Expr -> Context -> [Expr]
reProofDeduct _ _ [] = []
reProofDeduct ctx a (x:xs) =
 let e = expr x in
 let fwd  = reProofDeduct ctx a xs in
  case reason x of
   Axiom _ ->  [e, subAx 1 [("A", e), ("B", a)], a ~> e] ++ fwd
   Assumption -> [e, subAx 1 [("A", e), ("B", a)], a ~> e] ++ fwd
   Alpha -> (getSelfImplProof a) ++ fwd
   ModusPonens q _ ->  (getMPProof a (expr (ctx !! (q - 1))) e) ++ fwd
   NoProof -> error "NOPROFFOQA"

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

modusPonensSubCheck :: Expr -> Expr -> Maybe Expr
modusPonensSubCheck = undefined

modusPonensSub :: Expr -> Expr -> Expr
modusPonensSub _ (BinOp Impl _ y) = y

(~>) :: Expr -> Expr -> Expr
a ~> b = BinOp Impl a b

subAx :: Int -> [(String, Expr)] -> Expr
subAx n subs = substitute (axioms !! (n - 1)) subs

substitute :: Expr -> [(String, Expr)] -> Expr
substitute e subs = case e of
  BinOp t a b -> BinOp t (substitute a subs) (substitute b subs)
  UnOp t a -> UnOp t (substitute a subs)
  Statement a -> case lookUpSub a subs of
                   Nothing -> Statement a
                   Just s -> s

lookUpSub :: String -> [(String, Expr)] -> Maybe Expr
lookUpSub _ [] = Nothing
lookUpSub s ((a, b):xs) = if (a == s) then Just b
                          else lookUpSub s xs
--------------------------------------------------------------------
getDeductCtx :: MPsMap -> Context -> [Expr] -> Expr -> [Expr] -> Context
getDeductCtx _ ctx [] _ _ = ctx
getDeductCtx mps ctx (x:xs) a assump =
    let pos = (length ctx) + 1 in
    let r = checkAssump x a assump (verifier mps x) in
    let newMPs = updContext mps ctx x pos in
    getDeductCtx newMPs (ctx ++ [(Rule x r)]) xs a assump
--------------------------------------------------------------------
checkAssump :: Expr -> Expr -> [Expr] -> Result -> Reason
checkAssump x a assump (Right res)
    | res == NoProof && x == a = Alpha
    | res == NoProof && ((isAssump $! x) $! assump) = Assumption
    | otherwise = res

isAssump :: Expr -> [Expr] -> Bool
isAssump _ [] = False
isAssump e (x:xs)
         | e == x = True
         | otherwise = isAssump e xs
