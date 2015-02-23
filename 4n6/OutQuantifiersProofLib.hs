module OutQuantifiersProofLib where

import qualified Data.Map.Strict as M
import Syntax
import FAApplyDeductionLib
import FAModusPonens
import FASubstitutions
import Debug.Trace
import SupportOutQuant
import OutProofLib
import EqualProofLib

getMapOfQuant :: QuMap -> Expr -> QuMap
getMapOfQuant m (UnOp _ e) = getMapOfQuant m e 
getMapOfQuant m (BinOp _ e1 e2) = getMapOfQuant (getMapOfQuant m e1) e2 
getMapOfQuant m (Quantifier _ x e) =
    let newMap = getMapOfQuant m e in
    case M.lookup x newMap of
      Nothing -> M.insert x 1 newMap
      Just a -> M.insert x (a + 1) newMap
getMapOfQuant m _ = m

getOutQuantDeduct :: ProofMap -> Expr -> DeductionProof
getOutQuantDeduct proofMap e =
    let frees = freeV [] e in
    let mapQuant = getMapOfQuant M.empty e in
    let result = outQ proofMap frees mapQuant e in
    DeductionProof (outExpr result) [] (eqProof result)

----------------------------------------------------------------------------------------------------------------------------

outQ :: ProofMap -> [String] -> QuMap -> Expr -> ResultOutQ
outQ proofMap frees quantMap (BinOp t e1 e2) =
    let l = outQ proofMap frees quantMap e1 in
    let r = outQ proofMap frees (qMap l) e2 in
    let prfEq = getProofEqBin proofMap t e1 e2 (outExpr l) (outExpr r) in
    let (res, prfOut) = getProofOutBin proofMap t (outExpr l) (outExpr r) in
    let newPrf =
            (eqProof l) ++ (eqProof r) ++ prfEq ++ prfOut ++ (concatEq (BinOp t e1 e2) (BinOp t (outExpr l) (outExpr r)) res) in
    ResultOutQ (BinOp t e1 e2) res newPrf (qMap r)

outQ proofMap frees quantMap (UnOp t e1) = 
    let e = outQ proofMap frees quantMap e1 in
    let prfEq = getProofEqUn proofMap t e1 (outExpr e) in
    let (res, prfOut) = getProofOutUn proofMap t (outExpr e) in
    let newPrf =
            (eqProof e) ++ prfEq ++ prfOut ++ (concatEq (UnOp t e1) (UnOp t (outExpr e)) res) in
    ResultOutQ (UnOp t e1) res newPrf (qMap e)

outQ proofMap frees quantMap (Quantifier t x e1) =
    let e = outQ proofMap frees quantMap e1 in
    let prfEq = getProofEqQuant proofMap t x e1 (outExpr e) in
    let (ResultOutQ _ res prfRename newQuMap) = renameQuantifier proofMap frees (qMap e) (Quantifier t x (outExpr e)) in
    let newPrf =
            (eqProof e) ++ prfEq ++ prfRename ++ (concatEq (Quantifier t x e1) (Quantifier t x (outExpr e)) res) in
    ResultOutQ (Quantifier t x e1) res newPrf newQuMap

outQ _ _ quantMap e = ResultOutQ e e (getSelfImplProof e) quantMap
