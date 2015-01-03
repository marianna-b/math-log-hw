-- Synt.y -*- mode: haskell -*-
{
module Syntax where
import Lexer
}

%name synt
%tokentype { Token }
%monad { Either String } { (>>=) } { return }

%token
stmt { Stmt $$ }
'|' { BinOr }
'&' { BinAnd }
'!' { Not }
'->' { Implic }
'(' { LeftParen }
')' { RightParen }


%right '->'
%left '|'
%left '&'
%right '!'
%%

Expr:
Expr '&' Expr { BinOp And $1 $3 }
| Expr '|' Expr { BinOp Or $1 $3 }
| Expr '->' Expr { BinOp Impl $1 $3 }
| '!' Expr { UnOp LNot $2 }
| '(' Expr ')' { $2 }
| stmt { Statement $1 }
{

happyError _ = Left "syntax error"

data BinOpType = Or | And | Impl
               deriving Eq

instance Show BinOpType where
  show x = case x of
    Or -> "|"
    And -> "&"
    Impl -> "->"

data UnOpType = LNot
              deriving Eq

instance Show UnOpType where
  show x = "!"

data Expr = Statement String
          | BinOp BinOpType Expr Expr
          | UnOp UnOpType Expr
  deriving Eq

instance Show Expr where
  show x = case x of
    Statement s -> s
    BinOp t a b -> "(" ++ (show a) ++ (show t) ++ (show b) ++ ")"
    UnOp t a -> "("++(show a) ++ (show t) ++ ")"

}
