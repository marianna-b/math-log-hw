module AxiomCheck where

import Syntax
import Lexer
import qualified Data.Map.Strict as M
import Control.Monad.State
import FASubstitutions

type StmtMap = M.Map String Expr

axioms :: [Expr]
axioms = map parseExpr axiomsStr


parseExpr :: String -> Expr
parseExpr x = case tok x >>= syntExpr of
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
             "!!A->A"
            ]
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
matcher (UnOp UnNot a) (UnOp UnNot b) =
  matcher a b
matcher (PredicateSymb a []) b = do
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
checkAxioms :: Expr -> Result
checkAxioms e = checkAxioms' axioms e 1

-- The same as previous but with a number
checkAxioms' :: [Expr] -> Expr -> Int -> Result
checkAxioms' (x:xs) e n = if (match x e)
                         then Right $ Axiom n
                         else checkAxioms' xs e $ n + 1
checkAxioms' [] _ _ = Left NoProof
-------------------------------------------------------------------
checkPAxioms :: Expr -> Expr -> Result
checkPAxioms e _ =
  case checkAxiom11 e of
    Left err -> case checkAxiom12 e of
                  Left NoProof -> Left err
                  Left err2 -> Left err2
                  Right r -> Right r
    Right i -> Right i

checkAxiom11 :: Expr -> Result
checkAxiom11 (BinOp Impl (Quantifier Forall x e) b) =
  case checkIfSubsE x e b of
    NotFound -> Left NoProof
    Unknown -> Right $ Axiom 11
    Found y -> case checkFreeToSub e x y of
                 Nothing -> Right $ Axiom 11
                 Just err -> Left err
checkAxiom11 _ = Left NoProof

checkAxiom12 :: Expr -> Result
checkAxiom12 (BinOp Impl a (Quantifier Exists x e)) = 
  case checkIfSubsE x e a of
    NotFound -> Left NoProof
    Unknown -> Right $ Axiom 12
    Found y -> case checkFreeToSub e x y of
                 Nothing -> Right $ Axiom 12
                 Just err -> Left err
checkAxiom12 _ = Left NoProof
-- свободная переменная в допущении и квантор
