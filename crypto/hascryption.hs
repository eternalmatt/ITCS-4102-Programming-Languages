import Data.List

main = putStr $ concatMap (trueDecrypt thekey . trueEncrypt thekey) secrets


decrypt,trueDecrypt :: Integer -> Integer -> String
trueDecrypt key message = reverse (decrypt key message)

decrypt key message 
   | message <= key = []
   | otherwise      = letter : decrypt key ((message - intChar) `div` 128)
     where intChar = message `div` key `mod` 128
           letter  = charFromInt intChar


trueEncrypt :: Integer -> String -> Integer    
trueEncrypt key message = case reverse message of 
                 (c:cs) ->       key * intFromChar c + encrypt cs
   where encrypt (c:cs) = 128 * (key * intFromChar c + encrypt cs)
         encrypt []     = 0
           
           
ascii :: [Char]
ascii = [(toEnum 0)..]
           
charFromInt :: Integer -> Char
charFromInt n = ascii `genericIndex` n

intFromChar :: Char -> Integer
intFromChar c = ascii `indexOf` c
   where indexOf xs y = head [ i | (x,i)<-zip xs [0..], x == y]


thekey   =  43925490168452731
messages = [657283544027693586405973913936912676341316860151136582564041440,
            762158440814722218409670997866763993970236423491053273021270170,
            253262132952333831995121662054324568193258875445201983148665941,
            860669930383051094828380046079622968863517085136410890595760608,
            781811748281830352989488557417573583693051102964224942664590125,
            822416390125976509670768141097965886409376847628987159121865489,
            915523982326070161546651135364185543215004770371941496548944981,
            911051292099529766286289435282947264489230853142015083465572192]
secret = "Sometimes you can see a lot just by looking. (Yogi Berra)\nAn economist is an expert who can explain tomorrow why\nhis previous predictions for today did not happen."
secrets :: [String]
secrets = init' ++ [last']
   where phrases = splitBy 22 secret
         init' = init phrases
         last' = take 22 $ last phrases ++ repeat ' '

splitBy :: Int -> [a] -> [[a]]
splitBy _ [] = []
splitBy n xs = h : splitBy n t
     where (h,t) = splitAt n xs
   
{-
--alternate definitions for encryption algorithm.
trueEncrypt key message = encrypt key (reverse message) `div` 128
encrypt,trueEncrypt :: Integer -> String -> Integer
encrypt key []     = 0
encrypt key (c:cs) = 128 * (key * intChar + encrypt key cs)
                     where intChar = intFromChar c
-}

