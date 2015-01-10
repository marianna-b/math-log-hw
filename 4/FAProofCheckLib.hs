module FAProofCheckLib where

import Syntax
import AxiomCheck
import qualified Data.Map.Strict as M
import FAAxiomCheck
import FASubstitutions
import FAModusPonens

verifyCtx :: MPsMap -> PredMPMap -> Context -> Proof -> Expr -> [Expr] -> Either (Int, NotProoved) Context
verifyCtx _ _ ctx [] _ _ = Right ctx
verifyCtx mps mp ctx (x:xs) alpha assump =
  let pos = (length ctx) + 1 in
  case verifyExpr mps mp x alpha assump of
    Right r0 ->
        let newMPs = updContext mps ctx x pos in
        let newMP = updPContext mp x pos in
        let newCtx = ctx ++ [Rule x r0] in
        case verifyCtx newMPs newMP newCtx xs alpha assump of
          Left err0 -> Left err0
          Right ctx' -> Right ctx'
    Left err -> Left (pos, err)
  

verifyExpr :: MPsMap -> PredMPMap -> Expr -> Expr -> [Expr] -> Result
verifyExpr mps mp e alpha assump =
  if e == alpha then Right Alpha
  else if elem e assump then
    Right Assumption
  else
    case checkAxioms e of
      Right r0 -> Right r0
      Left _ -> case checkAxiomsFA e of
        Right r1 -> Right r1
        Left _ -> case checkPAxioms e alpha of
          Right r2 -> Right r2
          Left err1 -> case checkAxiomFA9 e alpha of
            Right r3 -> Right r3
            Left err2-> case checkMP mps mp e alpha of
              Right r4 -> Right r4
              Left NoProof -> case err1 of
                NoProof -> Left err2
                _ -> Left err1
              Left err3 -> Left err3

verifyCtxNoAssump :: MPsMap -> PredMPMap -> Context -> Proof -> Either (Int, NotProoved) Context
verifyCtxNoAssump _ _ ctx [] = Right ctx
verifyCtxNoAssump mps mp ctx (x:xs) =
  let pos = (length ctx) + 1 in
  case verifyExprNoAssump mps mp x of
    Right r0 ->
        let newMPs = updContext mps ctx x pos in
        let newMP = updPContext mp x pos in
        let newCtx = ctx ++ [Rule x r0] in
        case verifyCtxNoAssump newMPs newMP newCtx xs of
          Left err0 -> Left err0
          Right ctx' -> Right ctx'
    Left err -> Left (pos, err)
  

verifyExprNoAssump :: MPsMap -> PredMPMap -> Expr -> Result
verifyExprNoAssump mps mp e =
  let alpha = Equals ZeroTerm ZeroTerm in
    case checkAxioms e of
      Right r0 -> Right r0
      Left _ -> case checkAxiomsFA e of
        Right r1 -> Right r1
        Left _ -> case checkPAxioms e alpha of
          Right r2 -> Right r2
          Left err1 -> case checkAxiomFA9 e alpha of
            Right r3 -> Right r3
            Left err2-> case checkMP mps mp e alpha of
              Right r4 -> Right r4
              Left NoProof -> case err1 of
                NoProof -> Left err2
                _ -> Left err1
              Left err3 -> Left err3

verify :: DeductionProof -> Either (Int, NotProoved) Context
verify d =
  let mps = MPsMap M.empty M.empty M.empty in
  let prf = proof d in
  case assumption d of
      [] -> 
          verifyCtxNoAssump mps M.empty [] prf 
      _ -> 
          let assump = init $ assumption d in
          let alpha = last $ assumption d in
          verifyCtx mps M.empty [] prf alpha assump 
