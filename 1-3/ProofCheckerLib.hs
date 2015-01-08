module ProofCheckerLib where

import Lexer
import Syntax
import Control.Monad.State
import Data.Functor
import Debug.Trace
import qualified Data.Map.Strict as M

data Reason = ModusPonens Int Int
              | Axiom Int
              | NoProof
              | Assumption
              | Alpha
            deriving Eq

data MPsMap = MPsMap { found :: M.Map Expr (Int, Int),
                       rParts :: M.Map Expr [Int],
                       proved :: M.Map Expr Int
                     }

instance Show Reason where
  show a = case a of
    ModusPonens x y -> "(M.P. " ++ (show x) ++ ", " ++ (show y) ++ ")"
    Axiom ax  -> "(Сх. акс. " ++ (show ax) ++ ")"
    NoProof -> "(Не доказано)"
    Assumption -> "(Из предположения)"
    Alpha-> "(Из предположения A)"

type Result = Either String Reason

type Context = [Rule]
type StmtMap = M.Map String Expr

data Rule = Rule { expr :: Expr,
                   reason :: Reason }
          
instance Show Rule where
    show x = (show  (expr x)) ++ " " ++ (show (reason x))
-------------------------------------------------------------------
--AXIOMS

axioms :: [Expr]
axioms = map parseExpr axiomsStr

parseExpr :: String -> Expr
parseExpr x = case tok x >>= syntExprNoEoln of
        Right a -> a
        Left err -> error err

axiomsStr :: [String]
axiomsStr = ["A->B->A",
             "(A->B)->(A->B->C)->(A->C)",
             "A->B->A&B",
             "A&B->A",
             "A&B->B",
             "A->A|B",
             "B->A|B",
             "(A->Q)->(B->Q)->(A|B->Q)",
             "(A->B)->(A->!B)->!A",
             "!!A->A"]
-------------------------------------------------------------------
-- Function return an expression stored by a name
-- if it exists in a map
load :: String -> State StmtMap (Maybe Expr)
load s = do
  m <- get
  return $ s `M.lookup` m

-- Function stores an expression with a name in a map
-- Double storaging not checked
store :: String -> Expr -> State StmtMap ()
store s e = do
  m <- get
  put $ M.insert s e m

-- State monad and
sAnd :: State StmtMap Bool
        -> State StmtMap Bool
        -> State StmtMap Bool
sAnd = liftM2 (&&)


-- Functions checks if first expression is deduced
-- by substitutions from the second(axiom)
match :: Expr -> Expr -> Bool
match a b = evalState (matcher a b) $ M.fromList []

-- Same but monadic function
matcher :: Expr -> Expr -> State StmtMap Bool
matcher (BinOp Impl a1 a2) (BinOp Impl b1 b2) =
  matcher a1 b1 `sAnd` matcher a2 b2
matcher (BinOp Or a1 a2) (BinOp Or b1 b2) =
  matcher a1 b1 `sAnd` matcher a2 b2
matcher (BinOp And a1 a2) (BinOp And b1 b2) =
  matcher a1 b1 `sAnd` matcher a2 b2
matcher (UnOp LNot a) (UnOp LNot b) =
  matcher a b
matcher (Statement a) b = do
  i <- load a
  case i of
    Nothing -> store a b >> return True
    Just c -> if b == c
              then return True
              else return False

matcher _ _ = return False
-------------------------------------------------------------------
-- Function check s if an expression may be deduced from axioms
-- using substitution
checkAxioms :: Expr -> Maybe Int
checkAxioms e = checkAxioms' axioms e 1

-- The same as previous but with a number
checkAxioms' :: [Expr] -> Expr -> Int -> Maybe Int
checkAxioms' (x:xs) e n = if (match x e)
                         then Just n
                         else checkAxioms' xs e $ n + 1
checkAxioms' [] _ _ = Nothing
-------------------------------------------------------------------
-- Finds if there is an expression
-- given expression may be deduced from by MP
findMP :: MPsMap -> Expr -> Maybe (Int, Int)
findMP mps e = M.lookup e (found mps)
-------------------------------------------------------------------
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
runVerifier :: MPsMap -> Context -> Expr -> Either String (MPsMap, Context) 
runVerifier mps ctx e = case verifier mps e of
  Left str -> Left str
  Right a ->
    let pos = (length ctx) + 1 in
    let newMPs = updContext mps ctx e pos in
        Right $ (newMPs, ctx ++ [(Rule e a)])

verifier :: MPsMap -> Expr -> Result
verifier mps e = case checkAxioms e of
  Just idx -> Right $ Axiom idx
  Nothing -> case findMP mps e of
    Just (a, b) -> Right $ ModusPonens a b
    Nothing -> Right NoProof

verifLoop :: MPsMap -> Context -> [Expr] -> Context
verifLoop mps ctx (x:[]) = case runVerifier mps ctx x of
  Right (_, newCtx) -> newCtx
verifLoop mps ctx (x:xs) = case runVerifier mps ctx x of
  Right (newMPs, newCtx) -> verifLoop newMPs newCtx xs
  Left _ -> verifLoop mps ctx xs
