-- Lex.x -*- mode: haskell -*-
{
module Lexer where
import Numeric
}

%wrapper "monad"

$alpha = [A-Z]
$digit = [0-9]

tokens :-
  $white+				;
  [$alpha] [$alpha $digit]* { \(p,_,_,s) len -> return $ Stmt $ take len s }
  "|" { \(p,_,_,s) len -> return $ BinOr}
  "&" { \(p,_,_,s) len -> return $ BinAnd }
  "!"{ \(p,_,_,s) len -> return $ Not}
  "->"{ \(p,_,_,s) len -> return $ Implic}
  "("{ \(p,_,_,s) len -> return $ LeftParen }
  ")"{ \(p,_,_,s) len -> return $ RightParen }
{

alexEOF = return TEOF

alexScanTokens str = runAlex str $ do
  let loop = do tok <- alexMonadScan
                if tok == TEOF
                        then return []
                        else do toks <- loop
                                return (tok:toks)
  loop

data Token = Stmt String
           | BinOr
           | BinAnd
           | Not
           | Implic
           | LeftParen
           | RightParen
           | TEOF
           deriving (Eq)

instance Show Token where
  show x = case x of
    Stmt s -> s
    BinOr -> "|"
    BinAnd -> "&"
    Not -> "!"
    Implic -> "->"
    LeftParen -> "("
    RightParen -> ")"
    TEOF -> "(EOF)"
}
