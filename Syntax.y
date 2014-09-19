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
               deriving (Show, Eq)

data UnOpType = LNot
              deriving (Show, Eq)

data Expr = Statement String
          | BinOp BinOpType Expr Expr
          | UnOp UnOpType Expr
  deriving (Show, Eq)
}
