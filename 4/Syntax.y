-- Synt.y -*- mode: haskell -*-
{
module Syntax where
import Lexer
}

%name syntDeduct DeductionProof
%name syntExpr Expr
%name syntProof ProofList
%tokentype { Token }
%monad { Either String } { (>>=) } { return }

%token
var { TVariable $$ }
predicat { TPredicatSymb $$ }
'|' { TBinOr }
'&' { TBinAnd }
'!' { TNot }
'->' { TImplic }
'(' { TLeftParen }
')' { TRightParen }
'\n' { TEOLN }
',' { TComma }
'|-' { TTurnstile }
apostr { TApostrophe }
'0' { TZero }
'*' { TMultiply }
'+' { TPlus }
'=' { TEquality }
foralls { TQuantifierAll }
exists { TQuantifierExists }

%left '|-'
%left ','
%right '->'
%left '|'
%left '&'
%right '!'
%left '='
%left '+'
%left '*'
%right exists
%right foralls
%left apostr
%%

DeductionProof:
'|-' Expr '\n' ProofList { DeductionProof $2 [] $4 }
| AssumptionList '|-' Expr '\n' ProofList { DeductionProof $3 $1 $5 }

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
Expr '->' Expr { BinOp Impl $1 $3 }
| Expr '|' Expr { BinOp Or $1 $3 }
| Expr '&' Expr { BinOp And $1 $3 }
| FinalExpr { $1 }

FinalExpr:
'(' Expr ')' { $2 }
| '!' FinalExpr { UnOp UnNot $2 }
| foralls var FinalExpr { Quantifier Forall $2 $3 }
| exists var FinalExpr { Quantifier Exists $2 $3 }
| Term '=' Term { Equals $1 $3 }
| predicat TermList { PredicateSymb $1 $2 }
| predicat { PredicateSymb $1 [] }

TermList:
'(' TermListRev ')' { reverse $2 }

TermListRev:
Term { [$1] }
| TermListRev ',' Term { $3 : $1 }

Term:
AtomTerm { $1 }
| Term '+'Term { BinFunction Plus $1 $3 }
| Term '*' Term { BinFunction Mul $1 $3 }

AtomTerm:
var { Variable $1 }
| var TermList { MultiFunction $1 $2 }
| '0' { ZeroTerm }
| '(' Term ')' { $2 }
| AtomTerm apostr { Apostrophe $1 }

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

data UnOpType = UnNot
  deriving (Ord, Eq)

instance Show UnOpType where
  show x = "!"

data BinFunType = Plus | Mul
  deriving (Eq, Ord)

instance Show BinFunType where
  show x = case x of
    Plus -> "+"
    Mul -> "*"

data Term = BinFunction BinFunType Term Term
          | MultiFunction String [Term]
          | ZeroTerm
          | Apostrophe Term
          | Variable String
  deriving (Eq, Ord)

instance Show Term where
  show x = case x of
    ZeroTerm -> "0"
    Variable v -> v
    MultiFunction x list -> "(" ++ x ++ "(" ++ (showTermList "," list) ++ "))"
    BinFunction t a b -> "(" ++ (show a) ++ (show t) ++ (show b) ++ ")"
    Apostrophe a -> "("++(show a) ++ "')"

data QuType = Forall | Exists
  deriving (Eq, Ord)

instance Show QuType where
  show x = case x of
    Forall -> "@"
    Exists -> "?"

showTermList :: String -> [Term] -> String
showTermList _ [] = ""
showTermList _ (x:[]) = show x
showTermList c (x:xs) = (show x) ++ c ++ showTermList c xs

data Expr = Equals Term Term
          | PredicateSymb String [Term]
          | Quantifier QuType String Expr 
          | BinOp BinOpType Expr Expr
          | UnOp UnOpType Expr
  deriving (Eq, Ord)

instance Show Expr where
  show x = case x of
    Equals a b -> "(" ++ (show a) ++ "=" ++  (show b) ++ ")"
    Quantifier t x e -> "(" ++ (show t) ++ x ++ "(" ++ (show e) ++ "))"
    PredicateSymb x [] -> x
    PredicateSymb x list -> "(" ++ x ++ "(" ++ (showTermList "," list) ++ "))"
    BinOp t a b -> "(" ++ (show a) ++ (show t) ++ (show b) ++ ")"
    UnOp t a -> "("++(show t) ++ (show a) ++ ")"
}
