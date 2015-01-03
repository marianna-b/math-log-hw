import Syntax
import Lexer
import DeductionProver
import InputDeduction
import Prover

deductionLoop :: String -> DContext -> DContext -> IO ()
deductionLoop a (x:xs) ctx = do
  putStrLn $ getNewProof a x ctx
  deductionLoop a xs ctx
deductionLoop _ [] _ = return ()

verifyDeduct :: [Expr] -> Context -> [String] -> DContext
verifyDeduct assump ctx (x:xs) = let l = alexScanTokens x >>= synt in
  case l >>= runVerifierDeduct ctx of
    Right (newCtx, res) -> let e = last newCtx in
        (constrDRule e res x):(verifyDeduct assump newCtx xs)
    Left _ -> case l of
      Right q -> let w = checkAssump assump q in
        let aCtx = getAssumpContext ctx q in
        (DRule q w x):(verifyDeduct assump aCtx xs)
      Left _ -> (verifyDeduct assump ctx xs)
verifyDeduct _ _ []  = []

startDeductionLoop :: [String] -> IO ()
startDeductionLoop input = do
  putStrLn s
  deductionLoop a ctx ctx
    where ctx = verifyDeduct assump [] (tail input)
          assump = getAssump (head input)
          s = getNewHeader (head input)
          (g, _) = parseInput $ head input
          a = last g



main :: IO ()
main = do
  s <- getLine
  input <- readFile s
  startDeductionLoop $ lines input
