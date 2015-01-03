module DeductionProver where

import Syntax
import Prover

type DContext = [DRule]
data DRule = DRule { exp :: Expr,
                         reason :: DReason,
                         string :: String }
             deriving Show
data DReason = DAssump Int
                  | DAxiom Int
                  | DisA Int
                  | DModusPonens Int Int
                  deriving Show

getNewProof :: String -> DRule -> DContext -> String
getNewProof a rule ctx = case reason rule of
  DAssump _ -> getAxOrAs a $ string rule
  DAxiom _ -> getAxOrAs a $ string rule
  DisA _ -> getIsA a
  DModusPonens e _ -> getNewMP a (string rule) (string (ctx !! (e - 1)))

axiom1Str :: String -> String -> String
axiom1Str a b = "((" ++ a ++ ")->((" ++ b ++ ")->(" ++ a ++")))"

axiom2Str :: String -> String -> String -> String
axiom2Str a b c = "(" ++ (implStr a b) ++ "->" ++ (implStr3 a b c) ++ "->" ++ implStr a c ++")"

implStr :: String -> String -> String
implStr a b = "((" ++ a ++ ")->(" ++ b ++ "))"

implStr3 :: String -> String -> String -> String
implStr3 a b c = "((" ++ a ++ ")->((" ++ b ++ ")->(" ++ c ++ ")))"

getAxOrAs :: String -> String -> String
getAxOrAs a b = init $ unlines [b, axiom1Str b a, implStr a b]

getIsA :: String -> String
getIsA a = init $ unlines [axiom1Str a a,
                    axiom2Str a (implStr a a) a,
                    implStr (axiom1Str a (implStr a a)) (implStr a a),
                    axiom1Str a (implStr a a),
                    implStr a a]

getNewMP :: String -> String -> String -> String
getNewMP a i j = init $ unlines [axiom2Str a j i,
                            implStr (implStr3 a j i) (implStr a i),
                            implStr a i]

runVerifierDeduct :: Context -> Expr -> Either String (Context, Reason)
runVerifierDeduct ctx e = case verifier ctx e of
  Left str -> Left str
  Right a -> let (c, n) = updContext ctx e in
    Right $ (c ++ [(Rule e n (mesg a))], a)

getAssumpContext :: Context -> Expr -> Context
getAssumpContext ctx e = let (c, n) = updContext ctx e in
    c ++ [(Rule e n "assump")]

checkAssump' :: [Expr] -> Expr -> Int -> DReason
checkAssump' (_:[]) _ n = DisA n
checkAssump' (x:xs) e n = if (x == e) then
                            DAssump n
                          else checkAssump' xs e $ n + 1

checkAssump :: [Expr] -> Expr -> DReason
checkAssump a e = checkAssump' a e 0

constrDRule :: Rule -> Reason -> String -> DRule
constrDRule rule res str = case res of
  Axiom a -> DRule (expr rule) (DAxiom a) str
  ModusPonens c d -> DRule (expr rule) (DModusPonens c d) str
