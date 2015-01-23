-- Lex.x -*- mode: haskell -*-
{
module Lexer where
import Numeric
}

%wrapper "monad"

$alpha = [A-Z]
$digit = [0-9]

tokens :-
  " "				;
  [\t]				;
  [\r]				;
  [A-Z] $digit* { \(p,_,_,s) len -> return $ TPredicatSymb $ take len s }
  [a-z] $digit* { \(p,_,_,s) len -> return $ TVariable $ take len s }
  "," { \(p,_,_,s) len -> return $ TComma }
  [\n] { \(p,_,_,s) len -> return $ TEOLN }
  "|-" { \(p,_,_,s) len -> return $ TTurnstile }
  "|" { \(p,_,_,s) len -> return $ TBinOr }
  "&" { \(p,_,_,s) len -> return $ TBinAnd }
  "!" { \(p,_,_,s) len -> return $ TNot }
  "->" { \(p,_,_,s) len -> return $ TImplic }
  "(" { \(p,_,_,s) len -> return $ TLeftParen }
  ")" { \(p,_,_,s) len -> return $ TRightParen }
  "@" { \(p,_,_,s) len -> return $ TQuantifierAll }
  "?" { \(p,_,_,s) len -> return $ TQuantifierExists }
  "=" { \(p,_,_,s) len -> return $ TEquality }
  "+" { \(p,_,_,s) len -> return $ TPlus }
  "*" { \(p,_,_,s) len -> return $ TMultiply }
  "0" { \(p,_,_,s) len -> return $ TZero }
  "'" { \(p,_,_,s) len -> return $ TApostrophe }
{

alexEOF = return TEOF
          
tok str = runAlex str $ do
  let loop = do tok <- alexMonadScan
                if tok == TEOF
                        then return []
                        else do toks <- loop
                                return (tok:toks)
  loop

data Token = TVariable String
           | TPredicatSymb String
           | TBinOr
           | TBinAnd
           | TNot
           | TImplic
           | TLeftParen
           | TRightParen
           | TComma
           | TTurnstile
           | TEOLN
           | TEOF
           | TApostrophe
           | TZero
           | TMultiply
           | TPlus
           | TEquality
           | TQuantifierAll
           | TQuantifierExists
           deriving (Eq)

instance Show Token where
  show x = case x of
    TVariable s -> "Var " ++ s
    TPredicatSymb s -> "Predicatsymb " ++ s
    TBinOr -> "|"
    TBinAnd -> "&"
    TNot -> "!"
    TImplic -> "->"
    TLeftParen -> "("
    TRightParen -> ")"
    TComma -> ","
    TTurnstile -> "|-"
    TEOLN -> "(EOLN)\n"
    TEOF -> "(EOF)"
    TApostrophe -> "'"
    TZero -> "0"
    TMultiply -> "*"
    TPlus -> "+"
    TEquality -> "="
    TQuantifierAll -> "@"
    TQuantifierExists -> "?"
}
