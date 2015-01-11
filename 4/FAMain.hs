import Lexer
import Syntax
import qualified Data.Map.Strict as M
import FAProofCheckLib 
import FAApplyDeductionLib
import FAModusPonens
import FASubstitutions
import Debug.Trace

loadProof :: String -> M.Map String Proof -> IO (M.Map String Proof)
loadProof s proofMap = do
  inp <- readFile $ "atom-proof/" ++ s
  case tok inp >>= syntProof of
    Left s -> error s
    Right prf -> return $ M.insert s prf proofMap 

getProofMap :: IO ProofMap
getProofMap =
    loadProof "forall1" M.empty >>=
    loadProof "forall2" >>=
    loadProof "exists"

parseProof :: [String] -> [Expr]
parseProof [] = []
parseProof (x:xs)
 | x == "" = (parseProof xs)
 | otherwise = case tok x >>= syntExpr of
                 Left err -> error err
                 Right r -> r:(parseProof xs)

parseInput :: String -> DeductionProof
parseInput inp =
  let l = lines inp in
  let a = head l in
  case tok a >>= syntAssump of
    Left err -> error err
    Right d -> DeductionProof (statement d) (assumption d) $ parseProof $ tail l

deduct ::  String -> ProofMap -> String
deduct inp proofMap =
  let deductPrf = parseInput inp in
  case verify deductPrf of
    Left (pos, err) -> "Вывод некорректен начиная с формулы номер " ++ (show pos) ++ (show err) ++ "\n"
    Right newCtx ->
        show $ genNewProof proofMap deductPrf newCtx 

genNewProof :: ProofMap -> DeductionProof -> Context -> DeductionProof
genNewProof proofMap d ctx = applyDeduct d ctx proofMap

putOutCtx :: Context -> String
putOutCtx [] = ""
putOutCtx (x:xs) = (show x) ++ "\n" ++ (putOutCtx  xs)

instance Show Rule where
    show x = (show (expr x)) ++ "   " ++ (show (reason x)) 

main :: IO ()
main = do
  inp <- getContents
  proofMap <- getProofMap
  putStr $ deduct inp proofMap
