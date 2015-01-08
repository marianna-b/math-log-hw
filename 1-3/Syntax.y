-- Synt.y -*- mode: haskell -*-
{
module Syntax where
import Lexer
}

%name syntDeduct DeductionProof
%name syntExpr SingleExpr
%name syntExprNoEoln Expr
%name syntProof ProofList
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
'\n' { EOLN }
',' { Comma }
'|-' { Turnstile }

%left '|-'
%left ','
%right '->'
%left '|'
%left '&'
%right '!'
%%

SingleExpr:
Expr '\n' { $1 }

DeductionProof:
AssumptionList '|-' Expr '\n' ProofList { DeductionProof $3 $1 $5 }

AssumptionList:
AssumptionListRev { reverse $1 }

AssumptionListRev:
Expr { [$1] }
| AssumptionListRev ',' Expr { $3 : $1 }

ProofList:
ProofListRev{ reverse $1 }

ProofListRev:
Expr '\n' { [$1] }
| ProofListRev Expr '\n' { $2 : $1 }

Expr:
Expr '&' Expr { BinOp And $1 $3 }
| Expr '|' Expr { BinOp Or $1 $3 }
| Expr '->' Expr { BinOp Impl $1 $3 }
| '!' Expr { UnOp LNot $2 }
| '(' Expr ')' { $2 }
| stmt { Statement $1 }
{

happyError rest = Left $ "syntax error" ++ show rest

data DeductionProof =
    DeductionProof{
      statement :: Expr,
      assumption :: [Expr],
      proof :: [Expr]
    }
    deriving (Ord, Eq)

showExprList :: String -> [Expr] -> String
showExprList _ [] = ""
showExprList _ (x:[]) = show x
showExprList c (x:xs) = (show x) ++ c ++ showExprList c xs

             
instance Show DeductionProof where
    show x = (showExprList "," (assumption x)) ++ "|-" ++ (show (statement x)) ++ "\n" ++ (showExprList "\n" (proof x)) ++ "\n"

data BinOpType = Or | And | Impl
               deriving (Ord, Eq)

instance Show BinOpType where
  show x = case x of
    Or -> "|"
    And -> "&"
    Impl -> "->"

data UnOpType = LNot
              deriving (Ord, Eq)

instance Show UnOpType where
  show x = "!"

data Expr = Statement String
          | BinOp BinOpType Expr Expr
          | UnOp UnOpType Expr
  deriving (Eq, Ord)

instance Show Expr where
  show x = case x of
    Statement s -> s
    BinOp t a b -> "(" ++ (show a) ++ (show t) ++ (show b) ++ ")"
    UnOp t a -> "("++(show t) ++ (show a) ++ ")"
}
