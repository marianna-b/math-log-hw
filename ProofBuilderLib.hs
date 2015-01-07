module ProofBuilderLib where

import Syntax
import Data.List

type Proof = [Expr]

getProof :: Expr -> Either ([String], Int) Proof
getProof e =
  let var = nub $ getVarList e in
  let listProof = getEstimListProof e var 0 (2^(length var)) in
  case listProof of
    Left i -> Left (var, i)
    Right proofs -> Right $ mergeProofs var proofs
------------------------------------------------------------------------------
getVarList :: Expr -> [String]
getVarList e = case e of
  Statement a -> [a]
  BinOp _ a b -> (getVarList a) ++ (getVarList b)
  UnOp _ b -> getVarList b

getEstimListProof :: Expr -> [String] -> Int -> Int -> Either Int [Proof]
getEstimListProof e var i end = case getProofForEstim e var i of
  Nothing -> Left i
  Just prf -> if (i + 1 == end) then
                  Right [prf]
              else
                  fmap (prf :) $ getEstimListProof e var (i + 1) end

getProofForEstim :: Expr -> [String] -> Int -> Maybe Proof
getProofForEstim = undefined
------------------------------------------------------------------------------
mergeProofs :: [String] -> [Proof] -> Proof
mergeProofs = undefined
