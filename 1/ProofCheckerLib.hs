module ProofCheckerLib where

import Axioms
import Control.Monad.State
import Data.Functor
import qualified Data.Map.Strict as M
import Syntax

data Reason = ModusPonens Int Int
              | Axiom Int
              | NoProof

instance Show Reason where
  show a = case a of
    ModusPonens x y -> "(M.P. " ++ (show x) ++ ", " ++ (show y) ++ ")"
    Axiom ax  -> "(Сх. акс. " ++ (show ax) ++ ")"
    NoProof -> "(Не доказано)"

type Result = Either String Reason

type Context = [Rule]
type StmtMap = M.Map String Expr

data Rule = Rule { expr :: Expr,
                   mP :: Int,
                   reason :: Reason }
          
instance Show Rule where
    show x = (show  (expr x)) ++ " " ++ (show (reason x))
      
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

-- Function checks if an expression may be deduced from axioms
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
findMP :: Context -> Expr -> Maybe (Int, Int)
findMP c e = findMP' c e 1

-- The same as previous but with a number
findMP' :: Context -> Expr -> Int -> Maybe (Int, Int)
findMP' (r:xs) e n = if checkMP e r
                     then Just ((mP r) + 1, n)
                     else findMP' xs e $ n + 1
findMP' [] _ _ = Nothing

-- Checks if there is A for (A -> B), if B must be proved
checkMP:: Expr -> Rule -> Bool
checkMP e r = if (mP r) == -1
              then False
              else checkMP' e $ expr r

-- Checks if first expression can be deduced from second
checkMP' :: Expr -> Expr -> Bool
checkMP' e (BinOp Impl a b) = e == b
checkMP' _ _ = False

-------------------------------------------------------------------

-- Updates context with proved expression
-- add expr to Context &
-- check if expr may be used for MP
updContext :: Context -> Expr -> (Context, Int)
updContext c e = (contextMPUpd c e (length c), getExprMP c e 0)


contextMPUpd :: Context -> Expr -> Int -> Context
contextMPUpd (c:cx) e n = case expr c of
  BinOp Impl a b -> if (a == e)
                    then (Rule (expr c) n (reason c)):(contextMPUpd cx e n)
                    else c:(contextMPUpd cx e n)
  _              -> c:(contextMPUpd cx e n)
contextMPUpd [] _ _ = []

getExprMP :: Context -> Expr -> Int -> Int
getExprMP (c:cx) e n  = case e of
  BinOp Impl a _ -> if (a == expr c)
                      then n
                      else getExprMP cx e $ n + 1
  _                -> -1
getExprMP [] _ _ = -1

-------------------------------------------------------------------

-- Function gets context and expression
-- Runs verifier and updates context
-- Returns new context or a string "No proof found"
runVerifier :: Context -> Expr -> Either String Context
runVerifier ctx e = case verifier ctx e of
  Left str -> Left str
  Right a -> let (c, n) = updContext ctx e in
    Right $ c ++ [(Rule e n a)]


-- Function gets context and expression
-- Checks if it is deduced from axioms or from MP
-- Returns number of axiom, numbers of expression for MP
-- or an error string
verifier :: Context -> Expr -> Result
verifier c e = case checkAxioms e of
  Just idx -> Right $ Axiom idx
  Nothing -> case findMP c e of
    Just (a, b) -> Right $ ModusPonens a b
    Nothing -> Right NoProof

-- Functions gets context(m.b. empty) and list of expressions
-- Iterates through list and return new context
verifLoop :: Context -> [Expr] -> Context
verifLoop ctx (x:[])  = case runVerifier ctx x of
  Right newCtx -> newCtx
verifLoop ctx (x:xs) = case runVerifier ctx x of
  Right newCtx -> verifLoop newCtx xs
  Left _ -> verifLoop ctx xs
