module ProofBuilderLib where

import Syntax
import Lexer
import Data.List
import System.IO.Unsafe
import ApplyDeductionLib
import qualified Data.Map.Strict as M

type Proof = [Expr]
type ProofMap = M.Map String Proof

exclAssump :: ProofMap ->  Proof
exclAssump m = case M.lookup "excluded_assumption" m of
  Nothing -> error "Не загружены доказательства"
  Just a -> a

getProof :: ProofMap -> Expr -> Either ([String], Int) Proof
getProof proofMap e =
  let var = nub $ getVarList e in
  let listProof = getEstimListProof proofMap e var 0 (2^(length var)) in
  case listProof of
    Left i -> Left (var, i)
    Right proofs -> Right $ mergeProofs (exclAssump proofMap) e var proofs (length var)
------------------------------------------------------------------------------
getVarList :: Expr -> [String]
getVarList e = case e of
  Statement a -> [a]
  BinOp _ a b -> (getVarList a) ++ (getVarList b)
  UnOp _ b -> getVarList b

getEstimListProof :: ProofMap -> Expr -> [String] -> Int -> Int -> Either Int [Proof]
getEstimListProof proofMap e var i end = case getProofForEstim proofMap e var i of
  (False, _) -> Left i
  (True, prf) -> if (i + 1 == end) then
                  Right [prf]
              else
                  fmap (prf :) $ getEstimListProof proofMap e var (i + 1) end

getVarVal :: [String] -> Int -> String -> Int
getVarVal var mask s = case elemIndex s var of
  Nothing -> error $ "Unknown variable in expression " ++ s
  Just i -> (mask `div` (2 ^ i)) `mod` 2
------------------------------------------------------------------------------

proofFromFile :: ProofMap -> String -> Proof
proofFromFile proofMap s = case M.lookup s proofMap of
  Nothing -> error "Не загружены доказательства"
  Just a -> a

nB :: Bool -> String
nB p = if p then "1" else "0"

substituteInProof :: Proof -> [(String, Expr)] -> Proof
substituteInProof [] _ = []
substituteInProof (x:xs) sub = (substitute x sub) : (substituteInProof xs sub)

getProofFromFileBin :: ProofMap -> BinOpType -> Bool -> Bool -> Expr -> Expr -> (Bool, Proof)
getProofFromFileBin pM Impl l r lE rE = let fileName = "impl" ++ (nB l) ++ (nB r) in
  let prf = proofFromFile pM fileName in
  ((l && r) || (not l), substituteInProof prf [("A", lE), ("B", rE)])
getProofFromFileBin pM Or l r lE rE = let fileName = "or" ++ (nB l) ++ (nB r) in
  let prf = proofFromFile pM fileName in
  ((l || r), substituteInProof prf [("A", lE), ("B", rE)])
getProofFromFileBin pM And l r lE rE = let fileName = "and" ++ (nB l) ++ (nB r) in
  let prf = proofFromFile pM fileName in
  ((l && r), substituteInProof prf [("A", lE), ("B", rE)])

getProofFromFileUn :: ProofMap -> UnOpType -> Bool -> Expr  -> (Bool, Proof)
getProofFromFileUn pM LNot pr e = let fileName = "not" ++ (nB pr) in
  let prf = proofFromFile pM fileName in
  (not pr, substituteInProof prf [("A", e)])

getProofForEstim :: ProofMap -> Expr -> [String] -> Int -> (Bool, Proof)
getProofForEstim _ expr@(Statement s) var mask =
    if getVarVal var mask s == 0 then
        (False, [UnOp LNot expr])
    else (True, [expr])
getProofForEstim proofMap (BinOp t a b) var mask =
    let (left, lProof) = getProofForEstim proofMap a var mask in
    let (right, rProof) = getProofForEstim proofMap b var mask in
    let (middle, prf) = getProofFromFileBin proofMap t left right a b in
    (middle, lProof ++ rProof ++ prf)
getProofForEstim proofMap (UnOp t a) var mask =
    let (child, cProof) = getProofForEstim proofMap a var mask in
    let (par, prf) = getProofFromFileUn proofMap t child a in
    (par, cProof ++ prf)
------------------------------------------------------------------------------
mergeProofs :: Proof -> Expr -> [String] -> [Proof] -> Int -> Proof
mergeProofs _ _ _ prf 0 = head prf
mergeProofs eA e var prf len = let newPrf = mergeProofsOneLevel eA e 0 var prf in
    mergeProofs eA e (tail var) newPrf (len - 1)

mergeProofsOneLevel :: Proof -> Expr -> Int -> [String] -> [Proof] -> [Proof]
mergeProofsOneLevel _ _ _ _ [] = []
mergeProofsOneLevel eA e mask var (x:y:prf) =
  let assumpX = reverse $ getExprFromMask var mask in
  let assumpY = reverse $ getExprFromMask var (mask + 1) in
  let deductX = case getNewProof (last assumpX) (init assumpX) x of
                  Left err -> error err
                  Right prf1 -> prf1
  in
  let deductY = case getNewProof (last assumpY) (init assumpY) y of
                  Left err -> error err
                  Right prf2 -> prf2
  in
  let newprf = deductX ++ deductY ++ substituteInProof eA [("P", (Statement (head var))), ("A", e)] in
  newprf : (mergeProofsOneLevel eA e (mask + 2) var prf)


getExprFromMask :: [String] -> Int -> [Expr]
getExprFromMask [] _ = [] 
getExprFromMask var mask =
    let val = if (mask `mod` 2) == 0 then UnOp LNot (Statement (head var)) else Statement (head var) in
    val:(getExprFromMask (tail var) (mask`div` 2))
