module FASubstitutions where

import Syntax

data NotProoved = NoProof 
                | TermNotFree Term Expr String
                | VarFreeIn String Expr
                | VarQuantFreeAssump String Expr
instance Show NotProoved where
    show = undefined

data Reason = Axiom Int
            | AxiomFA Int
            | MP Int Int
            | MPPred Int
            | Assumption
            | Alpha

instance Show Reason where
  show a = case a of
    MP x y -> "(M.P. " ++ (show x) ++ ", " ++ (show y) ++ ")"
    MPPred  x-> "(M.P. " ++ (show x) ++ ")"
    Axiom ax  -> "(Сх. акс. " ++ (show ax) ++ ")"
    AxiomFA ax  -> "(Сх. акс./акс ФА " ++ (show ax) ++ ")"
    Assumption -> "(Из предположения)"
    Alpha-> "(Из предположения A)"

type Result = Either NotProoved Reason

data SubRes = Found Term | Unknown | NotFound

(<&&>) :: SubRes -> SubRes -> SubRes
(<&&>) Unknown b = b 
(<&&>) a Unknown = a 
(<&&>) _ NotFound = NotFound 
(<&&>) NotFound _ = NotFound 
(<&&>) (Found a) (Found b) =
  if a == b then
      Found a
  else
      NotFound

checkIfSubsT :: String -> Term -> Term -> SubRes
checkIfSubsT x (MultiFunction s1 l1) (MultiFunction s2 l2) =
  if s1 == s2 then checkIfSubsTL x l1 l2
  else NotFound
checkIfSubsT x (BinFunction t1 a1 b1) (BinFunction t2 a2 b2) =
  if t1 == t2 then 
    let r1 = checkIfSubsT x a1 a2 in
    let r2 = checkIfSubsT x b1 b2 in
    r1 <&&> r2
  else NotFound
checkIfSubsT _ ZeroTerm ZeroTerm = Unknown
checkIfSubsT x (Apostrophe a) (Apostrophe b) =
  checkIfSubsT x a b
checkIfSubsT x (Variable a) (Variable b)
  | a == x && a == b = Found $ Variable x
  | a == x = Found $ Variable b
  | a == b  = Unknown
  | otherwise = NotFound
checkIfSubsT x (Variable a) b
  | a == x = Found b
  | otherwise = NotFound
checkIfSubsT _ _ _ = NotFound


checkIfSubsTL :: String -> [Term] -> [Term] -> SubRes
checkIfSubsTL x y z =
    if (length y) == (length x) then
      checkIfSubsTL' Unknown x y z
    else
      NotFound

checkIfSubsTL' :: SubRes -> String -> [Term] -> [Term] -> SubRes
checkIfSubsTL' r _ [] [] = r
checkIfSubsTL' r x (y:ys) (z:zs) =
  checkIfSubsTL' ((checkIfSubsT x y z) <&&> r) x ys zs

checkIfSubsE :: String -> Expr -> Expr -> SubRes
checkIfSubsE x (BinOp t1 a1 b1) (BinOp t2 a2 b2) 
  | t1 == t2 = 
      let r1 = checkIfSubsE x a1 a2 in
      let r2 = checkIfSubsE x b1 b2 in
      r1 <&&> r2
  | otherwise = NotFound
checkIfSubsE x (UnOp UnNot a) (UnOp UnNot b) = 
  checkIfSubsE x a b
checkIfSubsE x (Quantifier t1 s1 e1) (Quantifier t2 s2 e2) 
  | t1 == t2 && s1 == x = if s1 == s2 && e1 == e2 then
                            Unknown
                          else NotFound
  | t1 == t2 && s1 == s2 = checkIfSubsE x e1 e2
  | otherwise = NotFound
checkIfSubsE x (Equals a1 b1) (Equals a2 b2) =
    let r1 = checkIfSubsT x a1 a2 in
    let r2 = checkIfSubsT x b1 b2 in
    r1 <&&> r2
checkIfSubsE x (PredicateSymb s1 l1) (PredicateSymb s2 l2) =
  if s1 == s2 then checkIfSubsTL x l1 l2 else NotFound
checkIfSubsE _ _ _ = NotFound

checkFreeToSub :: Expr -> String -> Term -> Maybe NotProoved
checkFreeToSub e x y =
  let f = varTerm y in
  if (checkVFree [] e x f) then Nothing
  else Just $ TermNotFree y e x

hasIntersect :: [String] -> [String] -> Bool
hasIntersect [] _ = False
hasIntersect (x:xs) y = if elem x y then
                            True
                        else
                            hasIntersect xs y

checkVFree :: [String] -> Expr -> String -> [String] -> Bool
checkVFree v (Quantifier _ s e) x f =
  checkVFree (s:v) e x f
checkVFree v (BinOp _ a b) x f =
    let r1 = checkVFree v a x f in
    let r2 = checkVFree v b x f in
    r1 && r2
checkVFree v (UnOp UnNot a) x f = checkVFree v a x f
checkVFree v (Equals a b) x f = 
  let vars = (varTerm a) ++ (varTerm b) in
  if elem x vars then
    not (hasIntersect v f)
  else True
      
checkVFree v (PredicateSymb _ l) x f =
  let vars = (varTermList l) in
  if elem x vars then
    not (hasIntersect v f)
  else True

unFree :: [String] -> [String] -> [String]
unFree _ [] = []
unFree a (x:xs) = if elem x a then
                      unFree a xs
                  else
                      x:(unFree a xs)

freeV :: [String] -> Expr -> [String]
freeV s (BinOp _ a b) = (freeV s a) ++ (freeV s b)
freeV s (UnOp UnNot a) = freeV s a
freeV s (Quantifier _ x e) = freeV (x:s) e
freeV s (Equals a b) =
    unFree s $ (varTerm a) ++ (varTerm b) 
freeV s (PredicateSymb _ l) = unFree s $ varTermList l

varTermList :: [Term] -> [String]
varTermList [] = []
varTermList (x:xs) = (varTerm x) ++ (varTermList xs)

varTerm :: Term -> [String]
varTerm (MultiFunction _ l) = varTermList l
varTerm (BinFunction _ a b) = (varTerm a) ++ (varTerm b)
varTerm ZeroTerm = []
varTerm (Apostrophe a) = varTerm a
varTerm (Variable a) = [a]
