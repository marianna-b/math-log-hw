module FAAxiomCheck where

import Syntax
import qualified Data.Map.Strict as M
import AxiomCheck
import Control.Monad.State
import FASubstitutions

type VarMap = M.Map String Term

axiomsFA :: [Expr]
axiomsFA = map parseExpr axiomsStr2

           
axiomsStr2 :: [String]
axiomsStr2 = ["a=b->a'=b'",
              "a=b->a=c->b=c",
              "a'=b'->a=b",
              "!a'=0",
              "a+b'=(a+b)'",
              "a+0=a",
              "a*0=0",
              "a*b'=a*b+a"
              ]

------------------------------------------------------------------------
-- Function return an expression stored by a name
-- if it exists in a map
loadFA :: String -> State VarMap (Maybe Term)
loadFA s = do
  m <- get
  return $ s `M.lookup` m

-- Function stores an expression with a name in a map
-- Double storaging not checked
storeFA :: String -> Term -> State VarMap ()
storeFA s e = do
  m <- get
  put $ M.insert s e m

-- State monad and
sAndFA :: State VarMap Bool
        -> State VarMap Bool
        -> State VarMap Bool
sAndFA = liftM2 (&&)


-- Functions checks if first expression is deduced
-- by substitutions from the second(axiom)
matchFA :: Expr -> Expr -> Bool
matchFA a b = evalState (matcherFA a b) $ M.fromList []

-- Same but monadic function
matcherFA :: Expr -> Expr -> State VarMap Bool
matcherFA (BinOp Impl a1 a2) (BinOp Impl b1 b2) =
  matcherFA a1 b1 `sAndFA` matcherFA a2 b2
matcherFA (UnOp UnNot a) (UnOp UnNot b) =
  matcherFA a b
matcherFA (Equals a1 b1) (Equals a2 b2) =
  termMatcher a1 a2 `sAndFA` termMatcher b1 b2
matcherFA _ _ = return False


termMatcher :: Term -> Term -> State VarMap Bool
termMatcher (BinFunction Plus a1 b1) (BinFunction Plus a2 b2) =
  termMatcher a1 a2 `sAndFA` termMatcher b1 b2
termMatcher (BinFunction Mul a1 b1) (BinFunction Mul a2 b2) =
  termMatcher a1 a2 `sAndFA` termMatcher b1 b2
termMatcher ZeroTerm ZeroTerm =
  return True
termMatcher (Apostrophe a) (Apostrophe b) =
  termMatcher a b
termMatcher (Variable a) b = do
    i <- loadFA a
    case i of
      Nothing -> storeFA a b >> return True
      Just c -> if b == c
                then return True
                else return False
termMatcher _ _ = return False
    

-------------------------------------------------------------------
-- Function check s if an expression may be deduced from axioms
-- using substitution
checkAxiomsFA :: Expr -> Result
checkAxiomsFA e = checkAxiomsFA' axiomsFA e 1

-- The same as previous but with a number
checkAxiomsFA' :: [Expr] -> Expr -> Int -> Result
checkAxiomsFA' (x:xs) e n = if (matchFA x e)
                         then Right $ AxiomFA n
                         else checkAxiomsFA' xs e $ n + 1
checkAxiomsFA' [] _ _ = Left NoProof

-------------------------------------------------------------------
checkAxiomFA9 :: Expr -> Expr -> Result
checkAxiomFA9 (BinOp Impl (BinOp And f0 (Quantifier Forall x (BinOp Impl fx fx'))) f) _ =
  if fx == f then
    case checkIfSubsE x fx f0 of
      Found i -> if not (i == ZeroTerm) then Left NoProof
                 else case checkIfSubsE x fx fx' of
                        Found j ->
                            if j == Apostrophe (Variable x) then
                                    Right $ AxiomFA 9
                            else Left NoProof
                        NotFound -> Left NoProof
                        Unknown -> Left NoProof
      NotFound -> Left NoProof
      Unknown -> Left NoProof
  else Left NoProof
checkAxiomFA9 _ _ = Left NoProof
-- свободная переменная в допущении и квантор?
