module JsonEncoder (
    encodeJson,
    JValue(..)
    ) where

--needed for intercalate
import Data.List

--The Json data structure
data JValue = JString String
            | JNumber Double
            | JBool Bool
            | JNull
            | JObject [(String, JValue)]
            | JArray [JValue]
              deriving (Eq, Ord, Show)


--Generates a number of spaces, used for indentation when generating
spaces :: Int -> String
spaces n = replicate n ' '

--converts the JValue to text
encode :: Int -> JValue -> String
encode _ (JString x)    = "\"" ++ x ++ "\""
encode _ (JNumber x)    = show x
encode _ (JBool   x)    = if x == True then "true" else "false"
encode _ (JNull)        = "null"

encode ns (JArray  x)   = "[" ++ (intercalate (", ") (map (encode ns) x)) ++ "]"
encode ns (JObject x)   =
    "{\n" ++ (intercalate (",\n") (map (exposeObject (ns + 4)) x)) ++ "\n" ++ (spaces ns) ++ "}"
    where exposeObject n (a, b) = (spaces n) ++ ("\"" ++ a ++ "\"") ++ ": " ++ (encode n b)

encodeJson :: JValue -> String
encodeJson jsonData = encode 0 jsonData