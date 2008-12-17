using System;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Globalization;
using System.Collections;
using System.Xml.Serialization;

namespace MakingWaves.Common.WS.Utils
{
	/// <summary>
	/// Useful utils for string manipulations.
	/// This class is only for static use. You can not make objects of this class.
	/// </summary>
	static public class StringUtils
	{
        /// <summary> A log4net handle for writing log for this class </summary>
        private readonly static log4net.ILog log = log4net.LogManager.GetLogger(typeof(StringUtils));
        
        /// <summary>
		/// Convert specified array to its debug string representation.
		/// Nested arrays will be converted recursively.
		/// </summary>
		/// <param name="arr">Array with data</param>
		/// <returns>String representation of the array</returns>
		public static string ArrayToString(Array arr)
		{
			string typeName = arr.ToString();
			typeName = typeName.Substring(0,typeName.Length-1);
			StringBuilder res = new StringBuilder(typeName);
			res.Append(arr.Length);
			res.Append("]{");
			for (int i=0;i<arr.Length;++i)
			{
				object obj = arr.GetValue(i);
				string str;
				if (obj is Array)
					str = ArrayToString((Array)obj);
				else
					str = obj.ToString();
				res.Append(str);
				if (i<arr.Length-1)
					res.Append(",");
			}
			res.Append("}");
			return res.ToString();
		}

		/// <summary>
		/// If in specified path exists string like "$(varname)", then replace these substrings with
		/// these environment variables.
		/// Additionally, 'additionalKeys' are treated as additional environment variables.
		/// Use substring "$()" instead of "$" if you want to leave string like "$(abc)" in your path
		/// (when folder is named "$(abc)").
		/// You may call <PRE>StringUtils.ExpandPathFromEnvironment(fileName, GeneralUtils.GetAdditionalPathEnvironmentVariables())</PRE>
		/// To include additional variables from HTTP application object.
		/// </summary>
		/// <param name="path"></param>
		/// <param name="additionalKeys">Additional keys and its values. Specify null if not used.</param>
		/// <returns></returns>
		public static string ExpandPathFromEnvironment(string path, Dictionary<string, string> additionalKeys)
		{
			if (path==null)
				return path;
			System.Text.RegularExpressions.MatchCollection mc;
			StringBuilder res = new StringBuilder();

			// Create a new Regex object and define the regular expression.
			System.Text.RegularExpressions.Regex r = new System.Text.RegularExpressions.Regex("\\$\\((\\w*)\\)");
			// Use the Matches method to find all matches in the input string.
			mc = r.Matches(path);
			// Loop through the match collection to retrieve all 
			// matches and positions.
			int lastPos = 0;
			for (int i = 0; i < mc.Count; i++)
			{
				// Add the match string to the string array.   
				string found = mc[i].Value;
				// cut starting '$(' and ending ')'
				string envName = found.Substring(2, found.Length - 3).ToLower();
				// Record the character position where the match was found.
				int envPos = mc[i].Index;
				// append from last pos to here
				res.Append(path.Substring(lastPos, envPos - lastPos));
				string envVal = "";
				if (envName.Length == 0)
				{
					// special case - if you want to leave path like "$(dsgas)", then use escaped
					// version of this path: "$()(dsgas)".
					envVal = "$";
				}
				if ((additionalKeys != null) && (additionalKeys.ContainsKey(envName)))
				{
					envVal = additionalKeys[envName];
				}
				else
				{
					envVal = Environment.GetEnvironmentVariable(envName);
					if (envVal == null)
						throw new MakingWaves.Common.WS.Exceptions.AdministratorException("Unknown environment variable \"" + envName + "\" in path: " + path);
				}
				// append this 
				res.Append(envVal);
				lastPos = envPos + found.Length;
			}
			// append the rest
			res.Append(path.Substring(lastPos));
			return res.ToString();
		}

		/// <summary>
		/// If a file 'fileRelative' is specified in file 'fileRoot' relative to directory where this file is,
		/// then this function counts a destination full path of 'fileRelative' to be used.
		/// This function does not check any existence of these files.
		/// E.g. for ('c:\aaa\bbb.xml','..\bb.xml') it returns 'c:\bb.xml', and for
		/// ('c:\ee\bb\nn.xml','d:\aa\tt\dd.xml') it returns 'd:\aa\tt\dd.xml'.
		/// </summary>
		/// <param name="fileRoot">A file from which to search for path.</param>
		/// <param name="fileRelative">A file for which to search full path.</param>
		/// <returns></returns>
		public static string GetFullPathFromRelativePaths(string fileRoot, string fileRelative)
		{
			if (System.IO.Path.IsPathRooted(fileRelative))
				return fileRelative;
			string fullPath = System.IO.Path.GetFullPath(fileRoot);
			string onlyPath = fullPath.Substring(0,
				fullPath.Length - System.IO.Path.GetFileName(fullPath).Length);
			string resPath = System.IO.Path.Combine(onlyPath, fileRelative);
			string res = System.IO.Path.GetFullPath(resPath);
			return res;
		}

		/// <summary>
		/// Parse double value. Accepts commas, points, etc.
		/// Uses Double.Parse internally and throws excepitons if necessary.
		/// To get double.NaN value in case of error, use TryGetDoubleFromString.
		/// </summary>
		/// <param name="txt"></param>
		/// <returns>Parsed value, or NaN if string is empty or not a valid double number</returns>
		public static double GetDoubleFromString(string txt)
		{
			// version from Rhamnous
			System.Globalization.NumberFormatInfo ninfo = new System.Globalization.NumberFormatInfo();
			ninfo.NumberDecimalSeparator = ",";
			string txt2 = txt.Replace('.', ',');
			return Double.Parse(txt2, ninfo);

			// version from SPC - now wrapped by TryGetDoubleFromString
			//System.Globalization.NumberFormatInfo ninfo = new System.Globalization.NumberFormatInfo();
			//ninfo.NumberDecimalSeparator = ".";
			//string txt2 = txt.Replace(',', '.').Trim();
			//if (txt2.Length == 0)
			//    return Double.NaN;
			//double res;
			//if (Double.TryParse(txt2, System.Globalization.NumberStyles.Float, ninfo, out res))
			//    return res;
			//return double.NaN;
		}

		/// <summary>
		/// Parse double value. Accepts commas, points, etc.
		/// Returns false if a conversion has failed.  Uses Double.TryParse internally.
		/// Does not throw exceptions according to problem with parsing.
		/// Puts double.NaN in result if conversion has failed.
		/// </summary>
		/// <param name="txt">The text with double value</param>
		/// <param name="result">The result. Contains double.NaN if conversion fails.</param>
		/// <returns>True if conversion succeeded and false if the value cannot be interpreted as valid double value.</returns>
		public static bool TryGetDoubleFromString(string txt, out double result)
		{
			System.Globalization.NumberFormatInfo ninfo = new System.Globalization.NumberFormatInfo();
			ninfo.NumberDecimalSeparator = ",";
			string txt2 = txt.Replace('.', ',').Trim();
			if (txt2.Length==0)
			{
				result = double.NaN;
				return false;
			}
			bool res = Double.TryParse(txt2, NumberStyles.Float, ninfo, out result);
			if (!res)
				result = double.NaN;
			return res;
		}

		/// <summary>
		/// Parse specified string of content like: "property=\"value\"; property2=\"value2\""
		/// to StringDictionary object.
		/// Properties must be separated with semicolon, and property values must be in quotation marks.
		/// Properly handles parameters like: "property=\"val1;val2;\\\"\"; prop=\"\\\"\";".
		/// It means escaped quotation marks characters in property value (only!) and semicolons in property values
		/// (in quoted content).
		/// To specify in value char: "\\\\" (double backslash), use "\/" (backslash and then slash).
		/// To Specify quotation mark character, use "\\\"" (backslash and quotation mark).
		/// </summary>
		/// <param name="txtInfo"></param>
		/// <returns></returns>
		public static Dictionary<string, string> ParsePropertyDefinitionsFromPlainText(string txtInfo)
		{
			// Can not use String.Split because of case: property="value;value"; property2="sanflas"
			Dictionary<string, string> dict = new Dictionary<string, string>();
			ArrayList propDefs = new ArrayList();
			{
				// divide text to separate property definitions
				int curPos = 0;
				int lastStart = 0;
				int txtLen = txtInfo.Length;
				bool inVal = false;
				while (true)
				{
					if (curPos >= txtLen)
					{
                        if (inVal)
                            throw new MakingWaves.Common.WS.Exceptions.AdministratorException(String.Format("Error in specified properties list ({0}): quoted string not ended", txtInfo));
						propDefs.Add(txtInfo.Substring(lastStart).Trim());
						break;
					}
					// finite-state automata
					if (inVal)
					{
						// if in value block, exit it only if another " is there (but not \")
						if ((txtInfo[curPos] == '\"') && ((curPos > 0) && (txtInfo[curPos - 1] != '\\')))
							inVal = false;
					}
					else
					{
						if (txtInfo[curPos] == '\"')
							inVal = true; // value is starting
						else if (txtInfo[curPos] == ';') // separator between properties
						{
							propDefs.Add(txtInfo.Substring(lastStart, curPos - lastStart).Trim());
							lastStart = curPos + 1;
						}
					}
					++curPos;
				}
			}
			// now we have separate trimmed properies in propDefs
			foreach (string prop in propDefs)
			{
				if (prop.Length <= 0)
					continue; // skip empty lines
				int idxEq = prop.IndexOf('=');
				int idxQuote = prop.IndexOf('\"');
                if ((idxEq == -1) || (idxQuote < idxEq))
                    throw new MakingWaves.Common.WS.Exceptions.AdministratorException(String.Format("Property definition ({0}) does not contain equal sign before quotation mark", prop));
				string propName = prop.Substring(0, idxEq).Trim();
				string propValueQuoted = prop.Substring(idxEq + 1).Trim();
				if ((propValueQuoted.Length < 2) ||
					(propValueQuoted[0] != '\"') || (propValueQuoted[propValueQuoted.Length - 1] != '\"') ||
					(propValueQuoted[propValueQuoted.Length - 2] == '\\'))
                    throw new MakingWaves.Common.WS.Exceptions.AdministratorException(String.Format("Property value in property definition ({0}) is not properly quoted", prop));
				string propValue = propValueQuoted.Substring(1, propValueQuoted.Length - 2);
				propValue = propValue.Replace("\\\"", "\"");
				propValue = propValue.Replace("\\/", "\\");
				dict.Add(propName, propValue);
			}
			return dict;
		}


		/// <summary>
		/// Parse specified string of content like: "property=\"value\"; property2=\"value2\""
		/// to StringDictionary object.
		/// Properties must be separated with semicolon, and property values must be in quotation marks.
		/// Properly handles parameters like: "property=\"val1;val2;\\\"\"; prop=\"\\\"\";".
		/// It means escaped quotation marks characters in property value (only!) and semicolons in property values
		/// (in quoted content).
		/// To specify in value char: "\\\\" (double backslash), use "\/" (backslash and then slash).
		/// To Specify quotation mark character, use "\\\"" (backslash and quotation mark).
		/// </summary>
		/// <param name="txtInfo"></param>
		/// <returns></returns>
		[Obsolete("Use newer version 'ParsePropertyDefinitionsFromPlainText' that returns generic Dictionary", false)] 
		public static StringDictionary ParsePropertyDefinitions(string txtInfo)
		{
			// Can not use String.Split because of case: property="value;value"; property2="sanflas"
			StringDictionary dict = new StringDictionary();
			ArrayList propDefs = new ArrayList();
			{
				// divide text to separate property definitions
				int curPos = 0;
				int lastStart = 0;
				int txtLen = txtInfo.Length;
				bool inVal = false;
				while (true)
				{
					if (inVal)
					{
						// if in value block, exit it only if another " is there (but not \")
						if ((txtInfo[curPos] == '\"') && ((curPos > 0) && (txtInfo[curPos - 1] != '\\')))
							inVal = false;
					}
					else
					{
						if (txtInfo[curPos] == '\"')
							inVal = true; // value is starting
						else if (txtInfo[curPos] == ';') // separator between properties
						{
							propDefs.Add(txtInfo.Substring(lastStart, curPos - lastStart).Trim());
							lastStart = curPos + 1;
						}
					}
					++curPos;
					if (curPos >= txtLen)
					{
						if (inVal)
							throw new MakingWaves.Common.WS.Exceptions.AdministratorException(String.Format("Error in specified properties list ({0}): quoted string not ended", txtInfo));
						propDefs.Add(txtInfo.Substring(lastStart).Trim());
						break;
					}
				}
			}
			// now we have separate trimmed properies in propDefs
			foreach (string prop in propDefs)
			{
				if (prop.Length <= 0)
					continue; // skip empty lines
				int idxEq = prop.IndexOf('=');
				int idxQuote = prop.IndexOf('\"');
				if ((idxEq == -1) || (idxQuote < idxEq))
                    throw new MakingWaves.Common.WS.Exceptions.AdministratorException(String.Format("Property definition ({0}) does not contain equal sign before quotation mark",prop));
				string propName = prop.Substring(0, idxEq).Trim();
				string propValueQuoted = prop.Substring(idxEq + 1).Trim();
				if ((propValueQuoted.Length < 2) ||
					(propValueQuoted[0] != '\"') || (propValueQuoted[propValueQuoted.Length - 1] != '\"') ||
					(propValueQuoted[propValueQuoted.Length - 2] == '\\'))
                    throw new MakingWaves.Common.WS.Exceptions.AdministratorException(String.Format("Property value in property definition ({0}) is not properly quoted", prop));
				string propValue = propValueQuoted.Substring(1, propValueQuoted.Length - 2);
				propValue = propValue.Replace("\\\"", "\"");
				propValue = propValue.Replace("\\/", "\\");
				dict.Add(propName, propValue);
			}
			return dict;
		}
		
		/// <summary>
		/// Convert double value to string, using traditional processing.
		/// Use dot as decimal separator, do not use special additional characters, etc.
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		public static string DoubleToStringPoint(double val)
		{
			System.Globalization.NumberFormatInfo nfi = new System.Globalization.NumberFormatInfo();
			nfi.NumberDecimalSeparator = ",";            
			return val.ToString(nfi);
		}

        /// <summary>
        /// Convert double value to string, using traditional processing.
        /// Use dot as decimal separator and add fixed number of decimals
        /// </summary>
        /// <param name="val">Value that should be converted to string</param>
        /// <param name="nodecimals">Number of decimals</param>
        /// <returns></returns>
        public static string DoubleToStringPoint(double val, int nodecimals)
        {
            System.Globalization.NumberFormatInfo nfi = new System.Globalization.NumberFormatInfo();
            nfi.NumberDecimalSeparator = ",";
            nfi.NumberDecimalDigits = nodecimals;
            return val.ToString("F", nfi);
        }

		/// <summary>
		/// Prepare string representation of delegate (which assembly, what namepace, method name)
		/// In case when assembly name is the same as namespace name, a resulting text is shortened.
		/// </summary>
		/// <param name="aDelegate">Delegate that should be represented as string</param>
		/// <returns>String representation of specified delegate</returns>
		public static string DelegateToString(Delegate aDelegate)
		{
			string moduleStr = aDelegate.Method.Module.ToString();
			Type classType = aDelegate.Method.ReflectedType;
			string classStr = aDelegate.Method.ReflectedType.ToString();
			StringBuilder res = new StringBuilder();
			res.Append(TypeToString(classType)); // assembly name+class name
			res.Append(".");
			res.Append(aDelegate.Method.Name);
			return res.ToString();
		}

		/// <summary>
		/// Prepare string representation of type (class/interface/enum/...)e (which assembly, what namepace, type name)
		/// In case when assembly name is the same as namespace name, a resulting text is shortened.
		/// </summary>
		/// <param name="aType">A type that should be described.</param>
		/// <returns>
		/// String representation of specified type
		/// </returns>
		public static string TypeToString(Type aType)
		{
			string moduleStr = aType.Module.ToString();
			string classStr = aType.ToString();
			StringBuilder res = new StringBuilder();
			res.Append(moduleStr);
			res.Append("/");
			if ((moduleStr.EndsWith(".dll", StringComparison.CurrentCultureIgnoreCase)) &&
				(classStr.StartsWith(moduleStr.Substring(0, moduleStr.Length - 4), StringComparison.CurrentCultureIgnoreCase)))
			{
				res.Append('~');
				res.Append(classStr.Substring(moduleStr.Length - 4));
			}
			else
				res.Append(classStr);
			return res.ToString();
		}

		/// <summary>
		/// Converts specified string to its byte[] representation, using UTF8 encoding.
		/// </summary>
		/// <param name="txt">Text to be encoded</param>
		/// <returns>Encoded text</returns>
		public static byte[] StringToByteArray(string txt)
		{
			return (new System.Text.UTF8Encoding()).GetBytes(txt);
		}
		
		/// <summary>
		/// Converts specified array of bytes (treating it as string encoded using UTF8 encoding)
		/// to its string representation.
		/// </summary>
		/// <param name="data">Array of bytes to be decoded</param>
		/// <returns>Decoded string</returns>
		public static string ByteArrayToString(byte[] data)
		{
			return (new System.Text.UTF8Encoding()).GetString(data);
		}

		/// <summary>
		/// Increase indent of specifeid text. It inserts specified text in front of each line.
		/// </summary>
		/// <param name="txt"></param>
		/// <param name="nTabs"></param>
		/// <returns></returns>
		public static string IncreaseTabIndent(string txt, string indentText)
		{
			return indentText+txt.Replace("\n","\n"+indentText);
		}

		/// <summary>
		/// Copy all elements from two-dimensional array with strings
		/// to one-dimensional array with strings.
		/// </summary>
		/// <param name="arrTwoDimensional">Two dimensional array</param>
		/// <returns>One dimensional array of strings</returns>
		public static string[] ArrayArrayStringToArrayString(string[][] arrTwoDimensional)
		{
			int nElems = 0;
			for (int i = 0; i < arrTwoDimensional.Length; ++i)
				nElems += arrTwoDimensional[i].Length;
			string[] res = new string[nElems];
			int curPosRes = 0;
			for (int i = 0; i < arrTwoDimensional.Length; ++i)
			{
				arrTwoDimensional[i].CopyTo(res, curPosRes);
				curPosRes += arrTwoDimensional[i].Length;
			}
			return res;
		}

		/// <summary>
		/// Write specified date as yyyy-MM-dd HH:mm:ss
		/// </summary>
		/// <param name="dateTime"></param>
		/// <returns></returns>
		public static string DateTimeToStringSortable(DateTime dateTime)
		{
			return dateTime.ToString("yyyy'-'MM'-'dd' 'HH':'mm':'ss");
		}

		/// <summary>
		/// Write specified date as yyyy-MM-dd
		/// </summary>
		/// <param name="dateTime">The date.</param>
		/// <returns>string representation of date.</returns>
		public static string DateToStringSortable(DateTime dateTime)
		{
			return dateTime.ToString("yyyy'-'MM'-'dd");
		}

		/// <summary>
		/// Parses string Strings to date time.
		/// Two formats are tried: "yyyy'-'MM'-'dd' 'HH':'mm':'ss" and "yyyy'-'MM'-'dd".
		/// </summary>
		/// <param name="txt">The text.</param>
		/// <param name="dateTime">The output date time.</param>
		/// <returns></returns>
		public static bool ParseDateTimeFromString(string txt, out DateTime dateTime)
		{
			IFormatProvider fp = CultureInfo.InvariantCulture;
			string format1 = "yyyy'-'MM'-'dd' 'HH':'mm':'ss";
			string format2 = "yyyy'-'MM'-'dd";
			bool res;
			// try longer version
			res =
				DateTime.TryParseExact(txt, format1, fp,
					System.Globalization.DateTimeStyles.AllowWhiteSpaces, out dateTime);
			if (res)
				return true;
			// try shorter version
			res =
				DateTime.TryParseExact(txt, format2, fp,
					System.Globalization.DateTimeStyles.AllowWhiteSpaces, out dateTime);
			if (res)
				return true;
			return false;
		}

		/// <summary>
		/// Formats number according to the length of the 'number'.
		/// Heuristic function.
		/// Returns text for user NaN or Infinity (for translations), if necessary.
		/// </summary>
		/// <param name="number">number to format</param>
		/// <returns>formated number</returns>
		public static string FormatNumber(double number)
		{
			if (double.IsNaN(number))
				return "[#double.NaN]";
			if (double.IsInfinity(number))
				return "[#double.Inifinity]";
			string format = "#";
			double number2 = Math.Abs(number);
			int index = StringUtils.DoubleToStringPoint(number).IndexOf('.');
			switch (index)
			{
				case 1:
					format = "0.######";
					break;
				case 2:
					format = "0.#####";
					break;
				case 3:
					format = "0.####";
					break;
				case 4:
					format = "0.###";
					break;
				case 5:
					format = "0.##";
					break;
				case 6:
					format = "0.#";
					break;
				default:
					format = "0.#";
					break;
			}

			return number.ToString(format);
		}

		/// <summary>
		/// Generate long string with all exception details (including inner exception).
		/// Call stack is generated for inner-most exception.
		/// </summary>
		/// <param name="exc"></param>
		/// <returns></returns>
		public static string ExceptionFormatDetails(Exception exc)
		{
			Exception innerMost = exc;
			while (innerMost.InnerException != null)
				innerMost = innerMost.InnerException;
			String res = "Exception texts:\r\n";
			res += ExceptionGetAllInnerExceptions(exc).Replace("\n", "\n\t");
			res += "\r\nCall stack (of inner-most exc):\r\n" + innerMost.StackTrace.Replace("\n", "\n\t");
			res += "\r\n";
			return res;
		}

		/// <summary>
		/// Escapes specified string against characters treated specially in string literals.
		/// E.g. '"' (qotes) and '\' (backslash).
		/// </summary>
		/// <param name="txt">Non-escaped string</param>
		/// <returns>Escaped string</returns>
		public static string EscapeStringForLiteral(string txt)
		{
			string res = txt;
			string[] escapeFrom = new string[] { "\\", "\"", "\t", "\r", "\n" };
			string[] escapeTo = new string[] { "\\", "\"", "t", "r", "n" }; // preceded by '\\'
			for (int i = 0; i < escapeFrom.Length; ++i)
				res = res.Replace(escapeFrom[i], "\\" + escapeTo[i]);
			return res;
		}

		/// <summary>
		/// Converts specified array of bytes (treating it as string encoded using UTF8 encoding)
		/// to its string representation.
		/// </summary>
		/// <param name="data">Array of bytes to be decoded</param>
		/// <returns>Decoded string</returns>
		public static string ByteArrayUTF8ToString(byte[] data)
		{
			return (new System.Text.UTF8Encoding()).GetString(data);
		}

		/// <summary>
		/// Get all inner exceptions of specified exception.
		/// Do not get call stack string.
		/// Gives exceptions in order from monst outer to most inner.
		/// </summary>
		/// <param name="exc">Exception from which to get data</param>
		/// <returns>String with text for user, no translation needed/supported</returns>
		public static string ExceptionGetAllInnerExceptions(Exception exc)
		{
			//// get all exceptions in reversed order
			//Stack<Exception> excs = new Stack<Exception>();
			//Exception e = exc;
			//while (e != null)
			//{
			//    excs.Push(e);
			//    e = e.InnerException;
			//}
			//// merge result text
			//StringBuilder res = new StringBuilder();
			//while (excs.Count > 0)
			//{
			//    res.Append(excs.Pop().Message);
			//    res.Append("\r\n");
			//}
			//return res.ToString();

			// Get all exception texts in order from most outer to most inner
			StringBuilder res = new StringBuilder();
			Exception e = exc;
			while (e != null)
			{
				res.Append(e.Message);
				res.Append("\r\n");
				e = e.InnerException;
			}
			return res.ToString();
		}

		/// <summary>
		/// Formats the exception for user eyes.
		/// This message contains only all Texts of inner exceptions, no call stacks.
		/// </summary>
		/// <param name="exc">The exc.</param>
		/// <returns></returns>
		public static string ExceptionFormatForUser(Exception exc)
		{
			Exception innerMost = exc;
			while (innerMost.InnerException != null)
				innerMost = innerMost.InnerException;
			String res = "";
			//res += "Excepiton information (English):\r\n";
			res += ExceptionGetAllInnerExceptions(exc).Replace("\n", "\n\t");
			res += "\r\n";
			return res;
		}

		/// <summary>
		/// Escapes the string for showing as HTML.
		/// Converts enters to &lt;br/&gt;, '&lt;' to '&amp;lt;' etc.
		/// </summary>
		/// <param name="txt">The Text to be escaped.</param>
		/// <returns></returns>
		public static string EscapeStringForHTML(string txt)
		{
			string res = txt;
			string[] escapeFrom = new string[] { "<", ">", "\n" };
			string[] escapeTo = new string[] { "&lt;", "&gt;", "<br/>" };
			for (int i = 0; i < escapeFrom.Length; ++i)
				res = res.Replace(escapeFrom[i], escapeTo[i]);
			return res;
		}

		/// <summary>
		/// Determines whether the string is empty (is null or has 0 length).
		/// </summary>
		/// <param name="str">The String.</param>
		/// <returns>
		/// 	True if empty
		/// </returns>
		public static bool IsStringEmpty(string str)
		{
			return (str == null) || (str.Length == 0);
		}

		/// <summary>
		/// Converts 2D string tab to Dictionary.
		/// String[][] contains two string[], first with keys and second with values.
		/// </summary>
		/// <param name="tab">The tab.</param>
		/// <returns>Dictionary</returns>
		public static Dictionary<string, string> Convert2DStringArrToDictionaryStringString(string[][] tab)
		{
			if (tab == null || tab.Length != 2)
				return null;
			if (tab[0] == null || tab[1] == null
				|| tab[0].Length != tab[1].Length)
				return null;

			Dictionary<string, string> res = new Dictionary<string, string>();
			for (int i = 0; i < tab[0].Length; i++)
			{
				res.Add(tab[0][i], tab[1][i]);
			}
			return res;
		}

		/// <summary>
		/// Converts the Dictionary to 2D string tab.
		/// String[][] contains two string[], first with keys and second with values.
		/// </summary>
		/// <param name="dict">The dictionary</param>
		/// <returns>2D string tab</returns>
		public static string[][] ConvertDictionaryStringString2ToDStringArr(Dictionary<string, string> dict)
		{
			if (dict == null)
				return null;
			string[][] tab = new string[2][];
			tab[0] = new string[dict.Count];
			tab[1] = new string[dict.Count];
			int i = 0;
			foreach (string key in dict.Keys)
			{
				tab[0][i] = key;
				tab[1][i] = dict[key];
				i++;
			}

			return tab;
		}

		/// <summary>
		/// Joins multiple strings.
		/// Inserts 'delimiter' if and only if it delimites non-empty strings.
		/// </summary>
		/// <param name="p">The p.</param>
		/// <param name="p_2">The P_2.</param>
		/// <returns></returns>
		public static string JoinNonEmptyStrings(string delimiter, IList<string> items)
		{
			StringBuilder res = new StringBuilder();
			bool wasElem = false;
			foreach (string s in items)
			{
				if ((s!=null) && (s.Length>0))
				{
					if (wasElem)
					{
						// if was an element but delimiter did not put, then do it now.
						res.Append(delimiter);
						wasElem = false;
					}
					res.Append(s);
					wasElem = true; // put delimiter before next item
				}
			}
			return res.ToString();
		}

	}
}
