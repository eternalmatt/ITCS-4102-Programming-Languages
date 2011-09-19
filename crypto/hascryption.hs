fileKey = "key.txt"
filePlain = "plain.txt"
fileEncryption = "encryption.txt"

main = do
   putStrLn "Would you like encryption or decryption (e/d)?"
   key <- readFile fileKey
   choice <- getLine
   whatdo choice
   
whatdo :: String -> IO ()
whatdo "encryption" = whatdo "e"
whatdo "e" = do plain <- readFile filePlain
                key   <- readFile fileKey
                let encryptions = encryptMessages (read key) plain
                    output = unlines (map show encryptions)
                putStrLn output
whatdo "decryption" = whatdo "d"
whatdo "d" = do file <- readFile fileEncryption
                key  <- readFile fileKey
                let encryptions = map read . reverse $ lines file
                    messages = decryptMessages (read key) encryptions
                putStrLn messages
whatdo _ = do putStrLn "Couldn't understand the input."
              main
   
decryptMessages :: Integer -> [Integer] -> String
decryptMessages key = reverse . concat . map (decrypt key)

encryptMessages :: Integer -> String -> [Integer]
encryptMessages key = map (encrypt key) . split22

decrypt :: Integer -> Integer -> String
decrypt key message
   | message <= key = []
   | otherwise      = intToChar letter : decrypt key more
       where letter = message `div` key `mod` 128
             more   = (message - letter) `div` 128


encrypt :: Integer -> String -> Integer
encrypt key message = case reverse message of
   reversed -> let (first:rest) = map charToInt reversed
               in key * (first + foldr (\x acc->128*(x+acc)) 0 rest)
           
           
ascii :: [(Char,Integer)]
ascii = zip [(toEnum 0)..] [0..]
           
intToChar :: Integer -> Char
intToChar n = head [ x | (x,i)<-ascii, i == n]

charToInt :: Char -> Integer
charToInt c = head [ i | (x,i)<-ascii, x == c]


split22 :: String -> [String]
split22 secret = init' ++ [last']
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

--some variables used during debugging                     
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
-}

