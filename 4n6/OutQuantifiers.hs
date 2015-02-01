import qualified Data.Map.Strict as M
import Lexer
import Syntax
import FAApplyDeductionLib
import FAModusPonens
import FASubstitutions
import ProofsQuantifiers

data ResultOutQ = ResultOutQ {
                      inExpr ::Expr,
                      outExpr :: Expr,
                      eqProof :: Proof,
                      qMap :: M.Map String Int
                }

type QuMap = M.Map String Int

parseInput :: String -> Expr
parseInput s = case tok s >>= syntExpr of
                 Left err -> error err
                 Right e -> e
main :: IO ()
main = do
  inp <- getContents
  proofMap <- getProofMap
  putStr $ show $ getOutQuantDeduct proofMap $ parseInput inp

getMapOfQuant :: QuMap -> Expr -> QuMap
getMapOfQuant m (UnOp _ e) = getMapOfQuant m e 
getMapOfQuant m (BinOp _ e1 e2) = getMapOfQuant (getMapOfQuant m e1) e2 
getMapOfQuant m (Quantifier _ x e) =
    let newMap = getMapOfQuant m e in
    case M.lookup x newMap of
      Nothing -> M.insert x 1 newMap
      Just a -> M.insert x (a + 1) newMap

getOutQuantDeduct :: ProofMap -> Expr -> DeductionProof
getOutQuantDeduct proofMap e =
    let frees = freeV [] e in
    let mapQuant = getMapOfQuant M.empty e in
    let result = outQ proofMap frees mapQuant e in
    DeductionProof (inExpr result) [(outExpr result)] (eqProof result)

getProofEqBin :: ProofMap -> BinOpType -> Expr -> Expr -> Expr -> Expr -> Proof
getProofEqBin proofMap t l1 r1 l2 r2 =
    let link = case t of
                And -> "replace/and" 
                Or -> "replace/or"
                Impl -> "replace/impl"
    in
    case M.lookup link proofMap of
      Nothing -> error "Error loading proofs"
      Just prf ->
        (substituteInProof prf [("A", l1),("B", r1),("A1", l2),("B1", r2)])
                              ++ (substituteInProof prf [("A", l2),("B", r2),("A1", l1),("B1", r1)])

getProofEqUn :: ProofMap -> UnOpType -> Expr -> Expr -> Proof
getProofEqUn proofMap _ e1 e2 = case M.lookup "replace/not" proofMap of
      Nothing -> error "Error loading proofs"
      Just prf ->
        (substituteInProof prf [("A", e1),("A1", e2)])
                              ++ (substituteInProof prf [("A", e1),("A1", e2)])

getProofEqQuant :: ProofMap -> QuType -> String -> Expr -> Expr -> Proof
getProofEqQuant proofMap t x e1 e2 =
  let link = case t of
               Forall -> "replace/forall"
               Exists -> "replace/exists"
  in
  case M.lookup link proofMap of
      Nothing -> error "Error loading proofs"
      Just prf -> (subsInProofQ prf [("x", x)] [("A", e1), ("A1", e2)]) ++ ( subsInProofQ prf [("x", x)] [("A", e2), ("A1", e1)])

---------------------------------------------------------------------------------------------------------------------------------

getLeftProof :: ProofMap -> BinOpType -> QuType -> Proof
getLeftProof proofMap t quType =
  let s = case quType of
            Forall -> "quantifiers/first/forall/"
            Exists -> "quantifiers/first/exists/"
  in let (a,b) = case t of
                And -> ("and1", "and2")
                Or -> ("or1", "or2")
                Impl -> ("impl1", "impl2")
  in let (Just prf1) = M.lookup (s ++ a) proofMap in
  let (Just prf2) = M.lookup (s ++ b) proofMap in
  prf1 ++ prf2

getRightProof :: ProofMap -> BinOpType -> QuType -> Proof
getRightProof proofMap t quType =
  let s = case quType of
            Forall -> "quantifiers/second/forall/"
            Exists -> "quantifiers/second/exists/"
  in let (a,b) = case t of
                And -> ("and1", "and2")
                Or -> ("or1", "or2")
                Impl -> ("impl1", "impl2")
  in let (Just prf1) = M.lookup (s ++ a) proofMap in
  let (Just prf2) = M.lookup (s ++ b) proofMap in
  prf1 ++ prf2

getLeftQuant :: BinOpType -> QuType -> QuType
getLeftQuant Impl Forall = Exists
getLeftQuant Impl Exists = Forall
getLeftQuant _ t = t

getNotQuant :: UnOpType -> QuType -> QuType
getNotQuant _ Forall = Exists
getNotQuant _ Exists = Forall

getUnProof :: ProofMap -> UnOpType -> QuType -> Proof
getUnProof proofMap _ quType =
  let s = case quType of
            Forall -> "quantifiers/single/forall/"
            Exists -> "quantifiers/single/exists/"
  in let (Just prf1) = M.lookup (s ++ "not1") proofMap in
  let (Just prf2) = M.lookup (s ++ "not2") proofMap in
  prf1 ++ prf2

---------------------------------------------------------------------------------------------------------------------------------
getProofOutBin :: ProofMap -> BinOpType -> Expr -> Expr -> (Expr, Proof)
getProofOutBin proofMap t q@(Quantifier quType x e1) e2 =
    let prfOut = subsInProofQ (getLeftProof proofMap t quType) [("x", x)] [("P", e1), ("Q", e2)] in
    let newQu = getLeftQuant t quType in
    let (res, prf) =  getProofOutBin proofMap t e1 e2 in
    let newPrf = prfOut ++ prf ++ (getProofEqQuant proofMap newQu x (BinOp t e1 e2) res) in
    let prfConc = (concatEq (BinOp t q e2) (Quantifier newQu x (BinOp t e1 e2)) (Quantifier newQu x res)) in
    (Quantifier newQu x res, newPrf ++ prfConc)
getProofOutBin proofMap t e1 q@(Quantifier quType x e2) = 
    let prfOut = subsInProofQ (getRightProof proofMap t quType) [("x", x)] [("P", e2), ("Q", e1)] in
    let (res, prf) =  getProofOutBin proofMap t e1 e2 in
    let newPrf = prfOut ++ prf ++ (getProofEqQuant proofMap quType x (BinOp t e1 e2) res) in
    let prfConc = (concatEq (BinOp t e1 q) (Quantifier quType x (BinOp t e1 e2)) (Quantifier quType x res)) in
    (Quantifier quType x res, newPrf ++ prfConc)
getProofOutBin _ t e1 e2 = ((BinOp t e1 e2), getSelfImplProof (BinOp t e1 e2))

getProofOutUn :: ProofMap -> UnOpType -> Expr -> (Expr, Proof)
getProofOutUn proofMap t q@(Quantifier quType x e1) =
    let prfOut = subsInProofQ (getUnProof proofMap t quType) [("x", x)] [("P", e1)] in
    let newQu = getNotQuant t quType in
    let (res, prf) = getProofOutUn proofMap t e1 in
    let newPrf = prfOut ++ prf ++ ( getProofEqQuant proofMap newQu x (UnOp UnNot e1) res) in
    let prfConc =  concatEq (UnOp t q) (Quantifier newQu x (UnOp t e1)) (Quantifier newQu x res) in
    (Quantifier newQu x res, newPrf ++ prfConc)
getProofOutUn _ t e = ((UnOp t e), getSelfImplProof (UnOp t e))

---------------------------------------------------------------------------------------------------------------------------------

concatEq :: Expr -> Expr -> Expr -> Proof
concatEq e1 e2 e3 =
  [(subAx 2 [("A", e1),("B", e2),("C", e3)]),
   (subAx 1 [("A", e2~>e3), ("B", e1)]),
   e1~>(e2~>e3), (e1~>(e2~>e3))~>(e1~>e3), (e1~>e3),
   (subAx 2 [("A", e3),("B", e2),("C", e1)]),
   (subAx 1 [("A", e2~>e1), ("B", e3)]),
   e3~>(e2~>e1), (e3~>(e2~>e1))~>(e3~>e1), (e3~>e1)]

----------------------------------------------------------------------------------------------------------------------------

renameQuantifier :: ProofMap -> [String] -> QuMap -> Expr -> ResultOutQ
renameQuantifier proofMap frees quantMap q@(Quantifier t x e) = 
  let (var, newQuMap) = getNewVariable frees quantMap x in
  if var == x then ResultOutQ q q [] quantMap else
  let link = case t of
               Forall -> "quantifiers/single/forall/rename"
               Exists -> "quantifiers/single/exists/rename"
  in let (Just prf) = M.lookup link proofMap in
  let subsE = subVar x var e in
  let prfRename1 = (subsInProofQ prf [("x", x), ("y", var)] [("P", e),("Q", subsE)]) in
  let prfRename2 = (subsInProofQ prf [("x", var), ("y", x)] [("P", subsE),("Q", e)]) in
  ResultOutQ q (Quantifier t var subsE) (prfRename1 ++ prfRename2) newQuMap
-- Replace P(y) with Q(y) in generated proof

getNewVariable :: [String] -> QuMap -> String -> (String, QuMap)
getNewVariable frees quantMap x = 
  let (Just a) = M.lookup x quantMap in
  let isFree = elem x frees in
  if isFree then
      if a == 1 then
          (x, quantMap)
      else getNewVarName frees quantMap x a
  else
    getNewVarName frees quantMap x a

getNewVarName :: [String] -> QuMap -> String -> Int -> (String, QuMap)
getNewVarName frees quantMap x idx =
  let newX = x ++ (show idx) in
  let isFree = elem newX frees in
  if not isFree then
    getNewVarName frees quantMap x (idx + 1)
  else
    case M.lookup newX quantMap of
      Just _ -> getNewVarName frees quantMap x (idx + 1)
      Nothing ->
        let (Just w) = M.lookup x quantMap in
        let newQuMap = M.insert newX 1 (M.insert x (w - 1) quantMap) in
        (newX, newQuMap)

----------------------------------------------------------------------------------------------------------------------------

outQ :: ProofMap -> [String] -> QuMap -> Expr -> ResultOutQ
outQ proofMap frees quantMap (BinOp t e1 e2) =
    let l = outQ proofMap frees quantMap e1 in
    let r = outQ proofMap frees (qMap l) e2 in
    let prfEq = getProofEqBin proofMap t e1 e2 (outExpr l) (outExpr r) in
    let (res, prfOut) = getProofOutBin proofMap t (outExpr l) (outExpr r) in
    let newPrf =
            (eqProof l) ++ (eqProof r) ++ prfEq ++ prfOut ++ (concatEq (BinOp t e1 e2) (BinOp t (outExpr l) (outExpr r)) res) in
    ResultOutQ (BinOp t e1 e2) res newPrf (qMap r)

outQ proofMap frees quantMap (UnOp t e1) = 
    let e = outQ proofMap frees quantMap e1 in
    let prfEq = getProofEqUn proofMap t e1 (outExpr e) in
    let (res, prfOut) = getProofOutUn proofMap t (outExpr e) in
    let newPrf =
            (eqProof e) ++ prfEq ++ prfOut ++ (concatEq (UnOp t e1) (UnOp t (outExpr e)) res) in
    ResultOutQ (UnOp t e1) res newPrf (qMap e)

outQ proofMap frees quantMap (Quantifier t x e1) =
    let e = outQ proofMap frees quantMap e1 in
    let prfEq = getProofEqQuant proofMap t x e1 (outExpr e) in
    let (ResultOutQ _ res prfRename newQuMap) = renameQuantifier proofMap frees quantMap (Quantifier t x (outExpr e)) in
    let newPrf =
            (eqProof e) ++ prfEq ++ prfRename ++ (concatEq (Quantifier t x e1) (Quantifier t x (outExpr e)) res) in
    ResultOutQ (Quantifier t x e1) res newPrf newQuMap

outQ _ _ quantMap e = ResultOutQ e e (getSelfImplProof e) quantMap

--------------------------------------------------------------------------------------------------------------------------

subsInProofQ :: Proof -> [(String, String)] -> [(String, Expr)] -> Proof
subsInProofQ [] _ _ = []
subsInProofQ (x:xs) sub1 sub2 = (subQ x sub1 sub2) : (subsInProofQ xs sub1 sub2)

subQ :: Expr -> [(String, String)] -> [(String, Expr)] -> Expr
subQ e qu subs  = case e of
  BinOp t a b -> BinOp t (subQ a qu subs) (subQ b qu subs)
  UnOp t a -> UnOp t (subQ a qu subs)
  PredicateSymb a l -> case lookUpSub a subs of
                   Nothing -> PredicateSymb a l
                   Just s -> s
  Quantifier t x a -> case lookUpSubQ x qu of
                        Nothing -> Quantifier t x (subQ a qu subs)
                        Just y-> Quantifier t y (subQ a qu subs)

lookUpSubQ :: String -> [(String, String)] -> Maybe String
lookUpSubQ _ [] = Nothing
lookUpSubQ s ((a, b):xs) = if (a == s) then Just b
                          else lookUpSubQ s xs

--------------------------------------------------------------------------------------------------------------------------
subVarT :: String -> String -> Term -> Term
subVarT x y (MultiFunction s l) = MultiFunction s (subVarTL x y l)
subVarT x y (BinFunction t a b) =
  let r1 = subVarT x y a in
  let r2 = subVarT x y b in
  BinFunction t r1 r2
subVarT _ _ ZeroTerm = ZeroTerm
subVarT x y (Apostrophe a) = Apostrophe $ subVarT x y a
subVarT x y q@(Variable a) 
  | a == x = Variable y
  | otherwise = q

subVarTL :: String -> String -> [Term] -> [Term]
subVarTL _ _ [] = []
subVarTL x y (z:zs) = (subVarT x y z):(subVarTL x y zs)

subVar :: String -> String -> Expr -> Expr
subVar x y (BinOp t a b) = 
  let r1 = subVar x y a in
  let r2 = subVar x y b in
  BinOp t r1 r2
subVar x y (UnOp UnNot a) = 
  UnOp UnNot (subVar x y a)
subVar x y q@(Quantifier t s e)
  | s == x = Quantifier t y (subVar x y e)
  | s == y = q
  | otherwise = Quantifier t s (subVar x y e)
subVar x y (Equals a b) =
  let r1 = subVarT x y a in
  let r2 = subVarT x y b in
  Equals r1 r2
subVar x y (PredicateSymb s l) = PredicateSymb s (subVarTL x y l)
