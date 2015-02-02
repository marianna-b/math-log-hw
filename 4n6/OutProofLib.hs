module OutProofLib where
import qualified Data.Map.Strict as M
import Syntax
import FAApplyDeductionLib
import FAModusPonens
import Debug.Trace
import SupportOutQuant
import EqualProofLib

getProofOutBin :: ProofMap -> BinOpType -> Expr -> Expr -> (Expr, Proof)
getProofOutBin proofMap t q@(Quantifier quType x e1) e2 =
    let prfOut = subsInProofQ (getLeftProof proofMap t quType) [("x", x)] [("F", e1), ("G", e2)] in
    let newQu = getLeftQuant t quType in
    let (res, prf) =  getProofOutBin proofMap t e1 e2 in
    let newPrf = prfOut ++ prf ++ (getProofEqQuant proofMap newQu x (BinOp t e1 e2) res) in
    let prfConc = (concatEq (BinOp t q e2) (Quantifier newQu x (BinOp t e1 e2)) (Quantifier newQu x res)) in
    (Quantifier newQu x res, newPrf ++ prfConc)
getProofOutBin proofMap t e1 q@(Quantifier quType x e2) = 
    let prfOut = subsInProofQ (getRightProof proofMap t quType) [("x", x)] [("F", e2), ("G", e1)] in
    let (res, prf) =  getProofOutBin proofMap t e1 e2 in
    let newPrf = prfOut ++ prf ++ (getProofEqQuant proofMap quType x (BinOp t e1 e2) res) in
    let prfConc = (concatEq (BinOp t e1 q) (Quantifier quType x (BinOp t e1 e2)) (Quantifier quType x res)) in
    (Quantifier quType x res, newPrf ++ prfConc)
getProofOutBin _ t e1 e2 = ((BinOp t e1 e2), getSelfImplProof (BinOp t e1 e2))

getProofOutUn :: ProofMap -> UnOpType -> Expr -> (Expr, Proof)
getProofOutUn proofMap t q@(Quantifier quType x e1) =
    let prfOut = subsInProofQ (getUnProof proofMap t quType) [("x", x)] [("F", e1)] in
    let newQu = getNotQuant t quType in
    let (res, prf) = getProofOutUn proofMap t e1 in
    let newPrf = prfOut ++ prf ++ ( getProofEqQuant proofMap newQu x (UnOp UnNot e1) res) in
    let prfConc =  concatEq (UnOp t q) (Quantifier newQu x (UnOp t e1)) (Quantifier newQu x res) in
    (Quantifier newQu x res, newPrf ++ prfConc)
getProofOutUn _ t e = ((UnOp t e), getSelfImplProof (UnOp t e))

renameQuantifier :: ProofMap -> [String] -> QuMap -> Expr -> ResultOutQ
renameQuantifier proofMap frees quantMap q@(Quantifier t x e) = 
  let (var, newQuMap) = getNewVariable frees quantMap x in
  if var == x then ResultOutQ q q [] quantMap else
  let link = case t of
               Forall -> "quantifiers/single/forall/rename"
               Exists -> "quantifiers/single/exists/rename"
  in
  let (Just prf) = M.lookup link proofMap in
  let subsE = subVar x var e in
  let prfRename1 = (subsInProofQ prf [("x", x), ("y", var)] [("F", e),("Q", subsE)]) in
  let prfRename2 = (subsInProofQ prf [("x", var), ("y", x)] [("F", subsE),("Q", e)]) in
  ResultOutQ q (Quantifier t var subsE) (prfRename1 ++ prfRename2) newQuMap


getNewVariable :: [String] -> QuMap -> String -> (String, QuMap)
getNewVariable frees quantMap x = 
  let (Just a) = M.lookup x quantMap in
  let notFree = elem x frees in
  if notFree then
    getNewVarName frees quantMap x a
  else
    if a == 1 then
      (x, quantMap)
    else
      getNewVarName frees quantMap x a
  

getNewVarName :: [String] -> QuMap -> String -> Int -> (String, QuMap)
getNewVarName frees quantMap x idx =
  let newX = x ++ (show idx) in
  let notFree = elem newX frees in
  if notFree then
    getNewVarName frees quantMap x (idx + 1)
  else
    case M.lookup newX quantMap of
      Just _ -> getNewVarName frees quantMap x (idx + 1)
      Nothing ->
        let (Just w) = M.lookup x quantMap in
        let newQuMap = M.insert newX 1 (M.insert x (w - 1) quantMap) in
        (newX, newQuMap)

