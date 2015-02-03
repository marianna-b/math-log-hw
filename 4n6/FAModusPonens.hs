module FAModusPonens where

import Syntax
import FASubstitutions
import qualified Data.Map.Strict as M
import Debug.Trace

data Rule = Rule { expr :: Expr,
                   reason :: Reason }
type Context = [Rule]
type Proof = [Expr]

type PredMPMap = M.Map Expr Int
data MPsMap = MPsMap { found :: M.Map Expr (Int, Int),
                       rParts :: M.Map Expr [Int],
                       proved :: M.Map Expr Int
                     }

updBy :: MPsMap -> Context -> [Int] -> Int -> MPsMap
updBy mps _ [] _ = mps
updBy mps ctx (x:xs) pos =
    let item = expr $ ctx !! (x - 1) in
    let f = found mps in
    let r = rParts mps in
    let p = proved mps in
    let newMPs =
            case item of
              BinOp Impl _ b -> MPsMap (M.insert b (pos, x) f) r p
              _ -> error "Не импликация"
    in
    updBy newMPs ctx xs pos

updList :: MPsMap -> Context -> Expr -> Int -> MPsMap
updList mps ctx e pos =
    let r = (rParts mps) in
    case M.lookup e r of
      Nothing -> mps
      Just list ->
          let newMPs = updBy mps ctx list pos in
          let newR = M.delete e (rParts newMPs) in
          let newF = found newMPs in
          let newP = proved newMPs in
          MPsMap newF newR newP

updImpl :: MPsMap -> Expr -> Expr -> Int -> MPsMap
updImpl mps eL eR pos =
    let p = proved mps in
    let f = found mps in
    let r = rParts mps in
    case M.lookup eL p of
      Just i ->
          let nF = M.insert eR (i, pos) f in
          MPsMap nF r p
      Nothing ->
        case M.lookup eL r of
          Nothing ->
              let nR = M.insert eL [pos] r in
              MPsMap f nR p
          Just list ->
              let nR = M.insert eL (pos:list) r in
              MPsMap f nR p
-------------------------------------------------------------------
updContext :: MPsMap -> Context -> Expr -> Int -> MPsMap
updContext mps ctx e pos =
    let newMPs' = updList mps ctx e pos in
    let p = proved newMPs' in
    let f = found newMPs' in
    let r = rParts newMPs' in
    let nP = M.insert e pos p in
    let newMPs =  MPsMap f r nP in
    case e of
      BinOp Impl a b -> updImpl newMPs a b pos
      _              -> newMPs
-------------------------------------------------------------------
updPContext :: PredMPMap -> Expr -> Int -> PredMPMap
updPContext mp x@(BinOp Impl _ _) pos = M.insert x pos mp
updPContext mp _ _ = mp
-------------------------------------------------------------------
findMP :: MPsMap -> Expr -> Maybe (Int, Int)
findMP mps e = M.lookup e (found mps)
-------------------------------------------------------------------

checkForallMP :: PredMPMap -> String -> Expr -> Expr -> Expr -> Result
checkForallMP mp x a b alpha =
  let freeVar = freeV [] alpha in
  let freeVar2 = freeV [] a in
  if elem x freeVar then Left $ VQFreeAssumpInRule x alpha
  else if elem x freeVar2 then
         Left $ VarFreeIn x a
       else 
         case M.lookup (BinOp Impl a b) mp of
           Nothing -> Left NoProof
           Just i -> Right $ ForallMP i

checkExistsMP :: PredMPMap -> String -> Expr -> Expr -> Expr -> Result
checkExistsMP mp x a b alpha = 
  let freeVar = freeV [] alpha in
  let freeVar2 = freeV [] b in
  if elem x freeVar then Left $ VQFreeAssumpInRule x alpha
  else if elem x freeVar2 then
         Left $ VarFreeIn x b
       else 
         case M.lookup (BinOp Impl a b) mp of
           Nothing -> Left NoProof
           Just i -> Right $ ExistsMP i

findPredMP :: PredMPMap -> Expr -> Expr -> Result
findPredMP mp (BinOp Impl a@(Quantifier Exists x e1) b@(Quantifier Forall y e2)) alpha =
    case checkForallMP mp y a e2 alpha of
      Right r1 -> Right r1
      Left err -> case checkExistsMP mp x e1 b alpha of
                    Right r2 -> Right r2
                    Left NoProof -> Left err
                    Left err2 -> Left err2
                  
findPredMP mp (BinOp Impl (Quantifier Exists x e) b) alpha = checkExistsMP mp x e b alpha
findPredMP mp (BinOp Impl a (Quantifier Forall y e)) alpha = checkForallMP mp y a e alpha
findPredMP _ _ _ = Left NoProof  
-------------------------------------------------------------------
checkMP :: MPsMap -> PredMPMap -> Expr -> Expr -> Result
checkMP mps mp e alpha = case findMP mps e of
  Just (x, y) -> Right $ MP x y
  Nothing -> findPredMP mp e alpha
