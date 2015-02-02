module EqualProofLib where

import qualified Data.Map.Strict as M
import Syntax
import FAApplyDeductionLib
import FAModusPonens
import Debug.Trace
import SupportOutQuant

getProofEqBin :: ProofMap -> BinOpType -> Expr -> Expr -> Expr -> Expr -> Proof
getProofEqBin proofMap t l1 r1 l2 r2 =
    let link = case t of
                And -> "replace/and" 
                Or -> "replace/or"
                Impl -> "replace/impl"
    in
    case M.lookup link proofMap of
      Nothing -> error "Error loading proofs"
      Just prf ->
        (substituteInProof prf [("A", l1),("B", r1),("A1", l2),("B1", r2)])
                              ++ (substituteInProof prf [("A", l2),("B", r2),("A1", l1),("B1", r1)])

getProofEqUn :: ProofMap -> UnOpType -> Expr -> Expr -> Proof
getProofEqUn proofMap _ e1 e2 = case M.lookup "replace/not" proofMap of
      Nothing -> error "Error loading proofs"
      Just prf ->
        (substituteInProof prf [("A", e1),("A1", e2)])
                              ++ (substituteInProof prf [("A", e2),("A1", e1)])

getProofEqQuant :: ProofMap -> QuType -> String -> Expr -> Expr -> Proof
getProofEqQuant proofMap t x e1 e2 =
  let link = case t of
               Forall -> "replace/forall"
               Exists -> "replace/exists"
  in
  case M.lookup link proofMap of
      Nothing -> error "Error loading proofs"
      Just prf -> (subsInProofQ prf [("x", x)] [("A", e1), ("A1", e2)]) ++ ( subsInProofQ prf [("x", x)] [("A", e2), ("A1", e1)])

