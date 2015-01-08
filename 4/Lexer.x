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
  [A-Z] $digit* { \(p,_,_,s) len -> return $ PredicatSymb $ take len s }
  [a-z] $digit* { \(p,_,_,s) len -> return $ Variable $ take len s }
  "," { \(p,_,_,s) len -> return $ Comma }
  [\n] { \(p,_,_,s) len -> return $ EOLN }
  "|-" { \(p,_,_,s) len -> return $ Turnstile }
  "|" { \(p,_,_,s) len -> return $ BinOr }
  "&" { \(p,_,_,s) len -> return $ BinAnd }
  "!" { \(p,_,_,s) len -> return $ Not }
  "->" { \(p,_,_,s) len -> return $ Implic }
  "(" { \(p,_,_,s) len -> return $ LeftParen }
  ")" { \(p,_,_,s) len -> return $ RightParen }
  "@" { \(p,_,_,s) len -> return $ QuantifierAll }
  "?" { \(p,_,_,s) len -> return $ QuantifierExists }
  "=" { \(p,_,_,s) len -> return $ Equality }
  "+" { \(p,_,_,s) len -> return $ Plus }
  "*" { \(p,_,_,s) len -> return $ Multiply }
  "0" { \(p,_,_,s) len -> return $ Zero }
  "'" { \(p,_,_,s) len -> return $ Apostrophe }
{

alexEOF = return EOF
          
tok str = runAlex str $ do
  let loop = do tok <- alexMonadScan
                if tok == EOF
                        then return []
                        else do toks <- loop
                                return (tok:toks)
  loop

data Token = Variable String
           | PredicatSymb String
           | BinOr
           | BinAnd
           | Not
           | Implic
           | LeftParen
           | RightParen
           | Comma
           | Turnstile
           | EOLN
           | EOF
           | Apostrophe
           | Zero
           | Multiply
           | Plus
           | Equality
           | QuantifierAll
           | QuantifierExists
           deriving (Eq)

instance Show Token where
  show x = case x of
    Variable s -> "Var " ++ s
    PredicatSymb s -> "Predicatsymb " ++ s
    BinOr -> "|"
    BinAnd -> "&"
    Not -> "!"
    Implic -> "->"
    LeftParen -> "("
    RightParen -> ")"
    Comma -> ","
    Turnstile -> "|-"
    EOLN -> "(EOLN)\n"
    EOF -> "(EOF)"
    Apostrophe -> "'"
    Zero -> "0"
    Multiply -> "*"
    Plus -> "+"
    Equality -> "="
    QuantifierAll -> "@"
    QuantifierExists -> "?"
           
}
