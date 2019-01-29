module Main where

import JsonEncoder


test = JObject [("hj", JArray [JNumber 10]), ("§number", JNumber 12.0), ("tree", JObject [("height", JObject [("height", JNumber 10.0), ("width", JNumber 1.0)]), ("width", JNumber 1.0)])] 


main :: IO ()
main = writeFile "test.json" (encodeJson test)
