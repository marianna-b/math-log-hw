module FAProofCheckLib where

import Syntax
import AxiomCheck
import qualified Data.Map.Strict as M

type Context = [Rule]
type Proof = [Expr]
type StmtMap = M.Map String Expr
type VarMap = M.Map String Term

data Rule = Rule { expr :: Expr,
                   reason :: Reason }

data MPsMap = MPsMap { 
                       simple :: M.Map Expr Int,
                       found :: M.Map Expr (Int, Int),
                       rParts :: M.Map Expr [Int],
                       proved :: M.Map Expr Int
                     }

verifyCtx :: MPsMap -> Context -> Proof -> Expr -> [Expr] -> Either NotProoved Context
verifyCtx _ _ [] _ _ = Right []
verifyCtx mps ctx (x:xs) alpha assump =
    undefined


verify :: DeductionProof -> Either NotProoved Context
verify d =
    let stmt = statement d in
    let assump = init $ assumption d in
    let prf = proof d in
    let alpha = last $ assumption d in
    let mps = MPsMap M.empty M.empty M.empty M.empty in
    verifyCtx mps [] prf alpha assump
