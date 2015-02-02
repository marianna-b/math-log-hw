module SupportOutQuant where

import qualified Data.Map.Strict as M
import Syntax
import FAApplyDeductionLib
import FAModusPonens
import Debug.Trace

data ResultOutQ = ResultOutQ {
                      inExpr ::Expr,
                      outExpr :: Expr,
                      eqProof :: Proof,
                      qMap :: M.Map String Int
                }

type QuMap = M.Map String Int

---------------------------------------------------------------------------------------------------------------------------------
-- Getting proofs and quantifiers for different expressions

getLeftProof :: ProofMap -> BinOpType -> QuType -> Proof
getLeftProof proofMap t quType =
  let s = case quType of
            Forall -> "quantifiers/first/forall/"
            Exists -> "quantifiers/first/exists/"
  in
  let (a,b) = case t of
                And -> ("and1", "and2")
                Or -> ("or1", "or2")
                Impl -> ("impl1", "impl2")
  in
  let (Just prf1) = M.lookup (s ++ a) proofMap in
  let (Just prf2) = M.lookup (s ++ b) proofMap in
  prf1 ++ prf2

getRightProof :: ProofMap -> BinOpType -> QuType -> Proof
getRightProof proofMap t quType =
  let s = case quType of
            Forall -> "quantifiers/second/forall/"
            Exists -> "quantifiers/second/exists/"
  in
  let (a,b) = case t of
                And -> ("and1", "and2")
                Or -> ("or1", "or2")
                Impl -> ("impl1", "impl2")
  in
  let (Just prf1) = M.lookup (s ++ a) proofMap in
  let (Just prf2) = M.lookup (s ++ b) proofMap in
  prf1 ++ prf2

getLeftQuant :: BinOpType -> QuType -> QuType
getLeftQuant Impl Forall = Exists
getLeftQuant Impl Exists = Forall
getLeftQuant _ t = t

getNotQuant :: UnOpType -> QuType -> QuType
getNotQuant _ Forall = Exists
getNotQuant _ Exists = Forall

getUnProof :: ProofMap -> UnOpType -> QuType -> Proof
getUnProof proofMap _ quType =
  let s = case quType of
            Forall -> "quantifiers/single/forall/"
            Exists -> "quantifiers/single/exists/"
  in
  let (Just prf1) = M.lookup (s ++ "not1") proofMap in
  let (Just prf2) = M.lookup (s ++ "not2") proofMap in
  prf1 ++ prf2

---------------------------------------------------------------------------------------------------------------------------------
-- Concatination proof for two equivalence 
concatEq :: Expr -> Expr -> Expr -> Proof
concatEq e1 e2 e3 =
  [(subAx 2 [("A", e1),("B", e2),("C", e3)]),
   (subAx 1 [("A", e2~>e3), ("B", e1)]),
   e1 ~> (e2 ~> e3), (e1 ~> (e2 ~> e3)) ~> (e1 ~> e3), (e1 ~> e3),
   (subAx 2 [("A", e3),("B", e2),("C", e1)]),
   (subAx 1 [("A", e2 ~> e1), ("B", e3)]),
   e3 ~> (e2 ~> e1), (e3 ~> (e2 ~> e1))~>(e3 ~> e1), (e3 ~> e1)]

----------------------------------------------------------------------------------------------------------------------------
-- Substitution predicate symbols and variables in quantifiers

subsInProofQ :: Proof -> [(String, String)] -> [(String, Expr)] -> Proof
subsInProofQ [] _ _ = []
subsInProofQ (x:xs) sub1 sub2 = (subQ x sub1 sub2) : (subsInProofQ xs sub1 sub2)

subQ :: Expr -> [(String, String)] -> [(String, Expr)] -> Expr
subQ e qu subs  = case e of
  BinOp t a b -> BinOp t (subQ a qu subs) (subQ b qu subs)
  UnOp t a -> UnOp t (subQ a qu subs)
  PredicateSymb a l -> case lookUpSub a subs of
                   Nothing -> PredicateSymb a l
                   Just s -> s
  Quantifier t x a -> case lookUpSubQ x qu of
                        Nothing -> Quantifier t x (subQ a qu subs)
                        Just y-> Quantifier t y (subQ a qu subs)
  _ -> e

lookUpSubQ :: String -> [(String, String)] -> Maybe String
lookUpSubQ _ [] = Nothing
lookUpSubQ s ((a, b):xs) =
  if (a == s) then
    Just b
  else
    lookUpSubQ s xs

--------------------------------------------------------------------------------------------------------------------------
-- Substitution of variable in expression

subVarT :: String -> String -> Term -> Term
subVarT x y (MultiFunction s l) = MultiFunction s (subVarTL x y l)
subVarT x y (BinFunction t a b) =
  let r1 = subVarT x y a in
  let r2 = subVarT x y b in
  BinFunction t r1 r2
subVarT _ _ ZeroTerm = ZeroTerm
subVarT x y (Apostrophe a) = Apostrophe $ subVarT x y a
subVarT x y q@(Variable a) 
  | a == x = Variable y
  | otherwise = q

subVarTL :: String -> String -> [Term] -> [Term]
subVarTL _ _ [] = []
subVarTL x y (z:zs) = (subVarT x y z):(subVarTL x y zs)

subVar :: String -> String -> Expr -> Expr
subVar x y (BinOp t a b) = 
  let r1 = subVar x y a in
  let r2 = subVar x y b in
  BinOp t r1 r2
subVar x y (UnOp UnNot a) = 
  UnOp UnNot (subVar x y a)
subVar x y q@(Quantifier t s e)
  | s == x = Quantifier t y (subVar x y e)
  | s == y = q
  | otherwise = Quantifier t s (subVar x y e)
subVar x y (Equals a b) =
  let r1 = subVarT x y a in
  let r2 = subVarT x y b in
  Equals r1 r2
subVar x y (PredicateSymb s l) = PredicateSymb s (subVarTL x y l)
