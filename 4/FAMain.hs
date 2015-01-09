import Lexer
import Syntax
import qualified Data.Map.Strict as M
import FAProofCheckLib 
import FAApplyDeductionLib

getProofMap :: IO ProofMap
getProofMap = undefined

parseInput :: String -> DeductionProof
parseInput inp = case tok inp >>= syntDeduct of
  Left err -> error err
  Right d -> d

deduct ::  String -> String
deduct inp = let deductPrf = parseInput inp in
  case verify $ deductPrf of
    Left err -> show err
    Right newCtx ->
        case genNewProof deductPrf newCtx of
          Left err -> show err
          Right newDeductPrf -> show newDeductPrf


genNewProof :: DeductionProof -> Context -> Either NotProoved DeductionProof
genNewProof d ctx = case errorDeduct d ctx of
  Just err -> Left err
  Nothing -> case applyDeduct d ctx of
               Left err -> Left err
               Right newDeduct -> Right newDeduct



main :: IO ()
main = do
  inp <- getContents
  proofMap <- getProofMap
  putStrLn $ deduct inp
