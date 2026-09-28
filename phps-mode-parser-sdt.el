;;; phps-mode-parser-sdt.el --- Syntax directed translation for grammar -*- lexical-binding: t -*-

;; Copyright (C) 2018-2026  Free Software Foundation, Inc.


;;; Commentary:


;; Productions PHP 8.5 grammar:

;; Production 0: ((start) (top_statement_list))
;; Production 1: ((reserved_non_modifiers) (T_INCLUDE))
;; Production 2: ((reserved_non_modifiers) (T_INCLUDE_ONCE))
;; Production 3: ((reserved_non_modifiers) (T_EVAL))
;; Production 4: ((reserved_non_modifiers) (T_REQUIRE))
;; Production 5: ((reserved_non_modifiers) (T_REQUIRE_ONCE))
;; Production 6: ((reserved_non_modifiers) (T_LOGICAL_OR))
;; Production 7: ((reserved_non_modifiers) (T_LOGICAL_XOR))
;; Production 8: ((reserved_non_modifiers) (T_LOGICAL_AND))
;; Production 9: ((reserved_non_modifiers) (T_INSTANCEOF))
;; Production 10: ((reserved_non_modifiers) (T_NEW))
;; Production 11: ((reserved_non_modifiers) (T_CLONE))
;; Production 12: ((reserved_non_modifiers) (T_EXIT))
;; Production 13: ((reserved_non_modifiers) (T_IF))
;; Production 14: ((reserved_non_modifiers) (T_ELSEIF))
;; Production 15: ((reserved_non_modifiers) (T_ELSE))
;; Production 16: ((reserved_non_modifiers) (T_ENDIF))
;; Production 17: ((reserved_non_modifiers) (T_ECHO))
;; Production 18: ((reserved_non_modifiers) (T_DO))
;; Production 19: ((reserved_non_modifiers) (T_WHILE))
;; Production 20: ((reserved_non_modifiers) (T_ENDWHILE))
;; Production 21: ((reserved_non_modifiers) (T_FOR))
;; Production 22: ((reserved_non_modifiers) (T_ENDFOR))
;; Production 23: ((reserved_non_modifiers) (T_FOREACH))
;; Production 24: ((reserved_non_modifiers) (T_ENDFOREACH))
;; Production 25: ((reserved_non_modifiers) (T_DECLARE))
;; Production 26: ((reserved_non_modifiers) (T_ENDDECLARE))
;; Production 27: ((reserved_non_modifiers) (T_AS))
;; Production 28: ((reserved_non_modifiers) (T_TRY))
;; Production 29: ((reserved_non_modifiers) (T_CATCH))
;; Production 30: ((reserved_non_modifiers) (T_FINALLY))
;; Production 31: ((reserved_non_modifiers) (T_THROW))
;; Production 32: ((reserved_non_modifiers) (T_USE))
;; Production 33: ((reserved_non_modifiers) (T_INSTEADOF))
;; Production 34: ((reserved_non_modifiers) (T_GLOBAL))
;; Production 35: ((reserved_non_modifiers) (T_VAR))
;; Production 36: ((reserved_non_modifiers) (T_UNSET))
;; Production 37: ((reserved_non_modifiers) (T_ISSET))
;; Production 38: ((reserved_non_modifiers) (T_EMPTY))
;; Production 39: ((reserved_non_modifiers) (T_CONTINUE))
;; Production 40: ((reserved_non_modifiers) (T_GOTO))
;; Production 41: ((reserved_non_modifiers) (T_FUNCTION))
;; Production 42: ((reserved_non_modifiers) (T_CONST))
;; Production 43: ((reserved_non_modifiers) (T_RETURN))
;; Production 44: ((reserved_non_modifiers) (T_PRINT))
;; Production 45: ((reserved_non_modifiers) (T_YIELD))
;; Production 46: ((reserved_non_modifiers) (T_LIST))
;; Production 47: ((reserved_non_modifiers) (T_SWITCH))
;; Production 48: ((reserved_non_modifiers) (T_ENDSWITCH))
;; Production 49: ((reserved_non_modifiers) (T_CASE))
;; Production 50: ((reserved_non_modifiers) (T_DEFAULT))
;; Production 51: ((reserved_non_modifiers) (T_BREAK))
;; Production 52: ((reserved_non_modifiers) (T_ARRAY))
;; Production 53: ((reserved_non_modifiers) (T_CALLABLE))
;; Production 54: ((reserved_non_modifiers) (T_EXTENDS))
;; Production 55: ((reserved_non_modifiers) (T_IMPLEMENTS))
;; Production 56: ((reserved_non_modifiers) (T_NAMESPACE))
;; Production 57: ((reserved_non_modifiers) (T_TRAIT))
;; Production 58: ((reserved_non_modifiers) (T_INTERFACE))
;; Production 59: ((reserved_non_modifiers) (T_CLASS))
;; Production 60: ((reserved_non_modifiers) (T_CLASS_C))
;; Production 61: ((reserved_non_modifiers) (T_TRAIT_C))
;; Production 62: ((reserved_non_modifiers) (T_FUNC_C))
;; Production 63: ((reserved_non_modifiers) (T_METHOD_C))
;; Production 64: ((reserved_non_modifiers) (T_LINE))
;; Production 65: ((reserved_non_modifiers) (T_FILE))
;; Production 66: ((reserved_non_modifiers) (T_DIR))
;; Production 67: ((reserved_non_modifiers) (T_NS_C))
;; Production 68: ((reserved_non_modifiers) (T_FN))
;; Production 69: ((reserved_non_modifiers) (T_MATCH))
;; Production 70: ((reserved_non_modifiers) (T_ENUM))
;; Production 71: ((reserved_non_modifiers) (T_PROPERTY_C))
;; Production 72: ((semi_reserved) (reserved_non_modifiers))
;; Production 73: ((semi_reserved) (T_STATIC))
;; Production 74: ((semi_reserved) (T_ABSTRACT))
;; Production 75: ((semi_reserved) (T_FINAL))
;; Production 76: ((semi_reserved) (T_PRIVATE))
;; Production 77: ((semi_reserved) (T_PROTECTED))
;; Production 78: ((semi_reserved) (T_PUBLIC))
;; Production 79: ((semi_reserved) (T_READONLY))
;; Production 80: ((ampersand) (T_AMPERSAND_FOLLOWED_BY_VAR_OR_VARARG))
;; Production 81: ((ampersand) (T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG))
;; Production 82: ((identifier) (T_STRING))
;; Production 83: ((identifier) (semi_reserved))
;; Production 84: ((top_statement_list) (top_statement_list top_statement))
;; Production 85: ((top_statement_list) (%empty))
;; Production 86: ((namespace_declaration_name) (identifier))
;; Production 87: ((namespace_declaration_name) (T_NAME_QUALIFIED))
;; Production 88: ((namespace_name) (T_STRING))
;; Production 89: ((namespace_name) (T_NAME_QUALIFIED))
;; Production 90: ((legacy_namespace_name) (namespace_name))
;; Production 91: ((legacy_namespace_name) (T_NAME_FULLY_QUALIFIED))
;; Production 92: ((name) (T_STRING))
;; Production 93: ((name) (T_NAME_QUALIFIED))
;; Production 94: ((name) (T_NAME_FULLY_QUALIFIED))
;; Production 95: ((name) (T_NAME_RELATIVE))
;; Production 96: ((attribute_decl) (class_name))
;; Production 97: ((attribute_decl) (class_name argument_list))
;; Production 98: ((attribute_group) (attribute_decl))
;; Production 99: ((attribute_group) (attribute_group "," attribute_decl))
;; Production 100: ((attribute) (T_ATTRIBUTE attribute_group possible_comma "]"))
;; Production 101: ((attributes) (attribute))
;; Production 102: ((attributes) (attributes attribute))
;; Production 103: ((attributed_statement) (function_declaration_statement))
;; Production 104: ((attributed_statement) (class_declaration_statement))
;; Production 105: ((attributed_statement) (trait_declaration_statement))
;; Production 106: ((attributed_statement) (interface_declaration_statement))
;; Production 107: ((attributed_statement) (enum_declaration_statement))
;; Production 108: ((attributed_top_statement) (attributed_statement))
;; Production 109: ((attributed_top_statement) (T_CONST const_list ";"))
;; Production 110: ((top_statement) (statement))
;; Production 111: ((top_statement) (attributed_top_statement))
;; Production 112: ((top_statement) (attributes attributed_top_statement))
;; Production 113: ((top_statement) (T_HALT_COMPILER "(" ")" ";"))
;; Production 114: ((top_statement) (T_NAMESPACE namespace_declaration_name ";"))
;; Production 115: ((top_statement) (T_NAMESPACE namespace_declaration_name "{" top_statement_list "}"))
;; Production 116: ((top_statement) (T_NAMESPACE "{" top_statement_list "}"))
;; Production 117: ((top_statement) (T_USE mixed_group_use_declaration ";"))
;; Production 118: ((top_statement) (T_USE use_type group_use_declaration ";"))
;; Production 119: ((top_statement) (T_USE use_declarations ";"))
;; Production 120: ((top_statement) (T_USE use_type use_declarations ";"))
;; Production 121: ((use_type) (T_FUNCTION))
;; Production 122: ((use_type) (T_CONST))
;; Production 123: ((group_use_declaration) (legacy_namespace_name T_NS_SEPARATOR "{" unprefixed_use_declarations possible_comma "}"))
;; Production 124: ((mixed_group_use_declaration) (legacy_namespace_name T_NS_SEPARATOR "{" inline_use_declarations possible_comma "}"))
;; Production 125: ((possible_comma) (%empty))
;; Production 126: ((possible_comma) (","))
;; Production 127: ((inline_use_declarations) (inline_use_declarations "," inline_use_declaration))
;; Production 128: ((inline_use_declarations) (inline_use_declaration))
;; Production 129: ((unprefixed_use_declarations) (unprefixed_use_declarations "," unprefixed_use_declaration))
;; Production 130: ((unprefixed_use_declarations) (unprefixed_use_declaration))
;; Production 131: ((use_declarations) (use_declarations "," use_declaration))
;; Production 132: ((use_declarations) (use_declaration))
;; Production 133: ((inline_use_declaration) (unprefixed_use_declaration))
;; Production 134: ((inline_use_declaration) (use_type unprefixed_use_declaration))
;; Production 135: ((unprefixed_use_declaration) (namespace_name))
;; Production 136: ((unprefixed_use_declaration) (namespace_name T_AS T_STRING))
;; Production 137: ((use_declaration) (legacy_namespace_name))
;; Production 138: ((use_declaration) (legacy_namespace_name T_AS T_STRING))
;; Production 139: ((const_list) (const_list "," const_decl))
;; Production 140: ((const_list) (const_decl))
;; Production 141: ((inner_statement_list) (inner_statement_list inner_statement))
;; Production 142: ((inner_statement_list) (%empty))
;; Production 143: ((inner_statement) (statement))
;; Production 144: ((inner_statement) (attributed_statement))
;; Production 145: ((inner_statement) (attributes attributed_statement))
;; Production 146: ((inner_statement) (T_HALT_COMPILER "(" ")" ";"))
;; Production 147: ((statement) ("{" inner_statement_list "}"))
;; Production 148: ((statement) (if_stmt))
;; Production 149: ((statement) (alt_if_stmt))
;; Production 150: ((statement) (T_WHILE "(" expr ")" while_statement))
;; Production 151: ((statement) (T_DO statement T_WHILE "(" expr ")" ";"))
;; Production 152: ((statement) (T_FOR "(" for_exprs ";" for_cond_exprs ";" for_exprs ")" for_statement))
;; Production 153: ((statement) (T_SWITCH "(" expr ")" switch_case_list))
;; Production 154: ((statement) (T_BREAK optional_expr ";"))
;; Production 155: ((statement) (T_CONTINUE optional_expr ";"))
;; Production 156: ((statement) (T_RETURN optional_expr ";"))
;; Production 157: ((statement) (T_GLOBAL global_var_list ";"))
;; Production 158: ((statement) (T_STATIC static_var_list ";"))
;; Production 159: ((statement) (T_ECHO echo_expr_list ";"))
;; Production 160: ((statement) (T_INLINE_HTML))
;; Production 161: ((statement) (expr ";"))
;; Production 162: ((statement) (T_UNSET "(" unset_variables possible_comma ")" ";"))
;; Production 163: ((statement) (T_FOREACH "(" expr T_AS foreach_variable ")" foreach_statement))
;; Production 164: ((statement) (T_FOREACH "(" expr T_AS foreach_variable T_DOUBLE_ARROW foreach_variable ")" foreach_statement))
;; Production 165: ((statement) (T_DECLARE "(" const_list ")" declare_statement))
;; Production 166: ((statement) (";"))
;; Production 167: ((statement) (T_TRY "{" inner_statement_list "}" catch_list finally_statement))
;; Production 168: ((statement) (T_GOTO T_STRING ";"))
;; Production 169: ((statement) (T_STRING ":"))
;; Production 170: ((statement) (T_VOID_CAST expr ";"))
;; Production 171: ((catch_list) (%empty))
;; Production 172: ((catch_list) (catch_list T_CATCH "(" catch_name_list optional_variable ")" "{" inner_statement_list "}"))
;; Production 173: ((catch_name_list) (class_name))
;; Production 174: ((catch_name_list) (catch_name_list "|" class_name))
;; Production 175: ((optional_variable) (%empty))
;; Production 176: ((optional_variable) (T_VARIABLE))
;; Production 177: ((finally_statement) (%empty))
;; Production 178: ((finally_statement) (T_FINALLY "{" inner_statement_list "}"))
;; Production 179: ((unset_variables) (unset_variable))
;; Production 180: ((unset_variables) (unset_variables "," unset_variable))
;; Production 181: ((unset_variable) (variable))
;; Production 182: ((function_name) (T_STRING))
;; Production 183: ((function_name) (T_READONLY))
;; Production 184: ((function_declaration_statement) (function returns_ref function_name backup_doc_comment "(" parameter_list ")" return_type backup_fn_flags "{" inner_statement_list "}" backup_fn_flags))
;; Production 185: ((is_reference) (%empty))
;; Production 186: ((is_reference) (T_AMPERSAND_FOLLOWED_BY_VAR_OR_VARARG))
;; Production 187: ((is_variadic) (%empty))
;; Production 188: ((is_variadic) (T_ELLIPSIS))
;; Production 189: ((class_declaration_statement) (class_modifiers T_CLASS T_STRING extends_from implements_list backup_doc_comment "{" class_statement_list "}"))
;; Production 190: ((class_declaration_statement) (T_CLASS T_STRING extends_from implements_list backup_doc_comment "{" class_statement_list "}"))
;; Production 191: ((class_modifiers) (class_modifier))
;; Production 192: ((class_modifiers) (class_modifiers class_modifier))
;; Production 193: ((anonymous_class_modifiers) (class_modifier))
;; Production 194: ((anonymous_class_modifiers) (anonymous_class_modifiers class_modifier))
;; Production 195: ((anonymous_class_modifiers_optional) (%empty))
;; Production 196: ((anonymous_class_modifiers_optional) (anonymous_class_modifiers))
;; Production 197: ((class_modifier) (T_ABSTRACT))
;; Production 198: ((class_modifier) (T_FINAL))
;; Production 199: ((class_modifier) (T_READONLY))
;; Production 200: ((trait_declaration_statement) (T_TRAIT T_STRING backup_doc_comment "{" class_statement_list "}"))
;; Production 201: ((interface_declaration_statement) (T_INTERFACE T_STRING interface_extends_list backup_doc_comment "{" class_statement_list "}"))
;; Production 202: ((enum_declaration_statement) (T_ENUM T_STRING enum_backing_type implements_list backup_doc_comment "{" class_statement_list "}"))
;; Production 203: ((enum_backing_type) (%empty))
;; Production 204: ((enum_backing_type) (":" type_expr))
;; Production 205: ((enum_case) (T_CASE backup_doc_comment identifier enum_case_expr ";"))
;; Production 206: ((enum_case_expr) (%empty))
;; Production 207: ((enum_case_expr) ("=" expr))
;; Production 208: ((extends_from) (%empty))
;; Production 209: ((extends_from) (T_EXTENDS class_name))
;; Production 210: ((interface_extends_list) (%empty))
;; Production 211: ((interface_extends_list) (T_EXTENDS class_name_list))
;; Production 212: ((implements_list) (%empty))
;; Production 213: ((implements_list) (T_IMPLEMENTS class_name_list))
;; Production 214: ((foreach_variable) (variable))
;; Production 215: ((foreach_variable) (ampersand variable))
;; Production 216: ((foreach_variable) (T_LIST "(" array_pair_list ")"))
;; Production 217: ((foreach_variable) ("[" array_pair_list "]"))
;; Production 218: ((for_statement) (statement))
;; Production 219: ((for_statement) (":" inner_statement_list T_ENDFOR ";"))
;; Production 220: ((foreach_statement) (statement))
;; Production 221: ((foreach_statement) (":" inner_statement_list T_ENDFOREACH ";"))
;; Production 222: ((declare_statement) (statement))
;; Production 223: ((declare_statement) (":" inner_statement_list T_ENDDECLARE ";"))
;; Production 224: ((switch_case_list) ("{" case_list "}"))
;; Production 225: ((switch_case_list) ("{" ";" case_list "}"))
;; Production 226: ((switch_case_list) (":" case_list T_ENDSWITCH ";"))
;; Production 227: ((switch_case_list) (":" ";" case_list T_ENDSWITCH ";"))
;; Production 228: ((case_list) (%empty))
;; Production 229: ((case_list) (case_list T_CASE expr ":" inner_statement_list))
;; Production 230: ((case_list) (case_list T_CASE expr ";" inner_statement_list))
;; Production 231: ((case_list) (case_list T_DEFAULT ":" inner_statement_list))
;; Production 232: ((case_list) (case_list T_DEFAULT ";" inner_statement_list))
;; Production 233: ((match) (T_MATCH "(" expr ")" "{" match_arm_list "}"))
;; Production 234: ((match_arm_list) (%empty))
;; Production 235: ((match_arm_list) (non_empty_match_arm_list possible_comma))
;; Production 236: ((non_empty_match_arm_list) (match_arm))
;; Production 237: ((non_empty_match_arm_list) (non_empty_match_arm_list "," match_arm))
;; Production 238: ((match_arm) (match_arm_cond_list possible_comma T_DOUBLE_ARROW expr))
;; Production 239: ((match_arm) (T_DEFAULT possible_comma T_DOUBLE_ARROW expr))
;; Production 240: ((match_arm_cond_list) (expr))
;; Production 241: ((match_arm_cond_list) (match_arm_cond_list "," expr))
;; Production 242: ((while_statement) (statement))
;; Production 243: ((while_statement) (":" inner_statement_list T_ENDWHILE ";"))
;; Production 244: ((if_stmt_without_else) (T_IF "(" expr ")" statement))
;; Production 245: ((if_stmt_without_else) (if_stmt_without_else T_ELSEIF "(" expr ")" statement))
;; Production 246: ((if_stmt) (if_stmt_without_else))
;; Production 247: ((if_stmt) (if_stmt_without_else T_ELSE statement))
;; Production 248: ((alt_if_stmt_without_else) (T_IF "(" expr ")" ":" inner_statement_list))
;; Production 249: ((alt_if_stmt_without_else) (alt_if_stmt_without_else T_ELSEIF "(" expr ")" ":" inner_statement_list))
;; Production 250: ((alt_if_stmt) (alt_if_stmt_without_else T_ENDIF ";"))
;; Production 251: ((alt_if_stmt) (alt_if_stmt_without_else T_ELSE ":" inner_statement_list T_ENDIF ";"))
;; Production 252: ((parameter_list) (non_empty_parameter_list possible_comma))
;; Production 253: ((parameter_list) (%empty))
;; Production 254: ((non_empty_parameter_list) (attributed_parameter))
;; Production 255: ((non_empty_parameter_list) (non_empty_parameter_list "," attributed_parameter))
;; Production 256: ((attributed_parameter) (attributes parameter))
;; Production 257: ((attributed_parameter) (parameter))
;; Production 258: ((optional_cpp_modifiers) (%empty))
;; Production 259: ((optional_cpp_modifiers) (non_empty_member_modifiers))
;; Production 260: ((parameter) (optional_cpp_modifiers optional_type_without_static is_reference is_variadic T_VARIABLE backup_doc_comment optional_property_hook_list))
;; Production 261: ((parameter) (optional_cpp_modifiers optional_type_without_static is_reference is_variadic T_VARIABLE backup_doc_comment "=" expr optional_property_hook_list))
;; Production 262: ((optional_type_without_static) (%empty))
;; Production 263: ((optional_type_without_static) (type_expr_without_static))
;; Production 264: ((type_expr) (type))
;; Production 265: ((type_expr) ("?" type))
;; Production 266: ((type_expr) (union_type))
;; Production 267: ((type_expr) (intersection_type))
;; Production 268: ((type) (type_without_static))
;; Production 269: ((type) (T_STATIC))
;; Production 270: ((union_type_element) (type))
;; Production 271: ((union_type_element) ("(" intersection_type ")"))
;; Production 272: ((union_type) (union_type_element "|" union_type_element))
;; Production 273: ((union_type) (union_type "|" union_type_element))
;; Production 274: ((intersection_type) (type T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG type))
;; Production 275: ((intersection_type) (intersection_type T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG type))
;; Production 276: ((type_expr_without_static) (type_without_static))
;; Production 277: ((type_expr_without_static) ("?" type_without_static))
;; Production 278: ((type_expr_without_static) (union_type_without_static))
;; Production 279: ((type_expr_without_static) (intersection_type_without_static))
;; Production 280: ((type_without_static) (T_ARRAY))
;; Production 281: ((type_without_static) (T_CALLABLE))
;; Production 282: ((type_without_static) (name))
;; Production 283: ((union_type_without_static_element) (type_without_static))
;; Production 284: ((union_type_without_static_element) ("(" intersection_type_without_static ")"))
;; Production 285: ((union_type_without_static) (union_type_without_static_element "|" union_type_without_static_element))
;; Production 286: ((union_type_without_static) (union_type_without_static "|" union_type_without_static_element))
;; Production 287: ((intersection_type_without_static) (type_without_static T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG type_without_static))
;; Production 288: ((intersection_type_without_static) (intersection_type_without_static T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG type_without_static))
;; Production 289: ((return_type) (%empty))
;; Production 290: ((return_type) (":" type_expr))
;; Production 291: ((argument_list) ("(" ")"))
;; Production 292: ((argument_list) ("(" non_empty_argument_list possible_comma ")"))
;; Production 293: ((argument_list) ("(" T_ELLIPSIS ")"))
;; Production 294: ((non_empty_argument_list) (argument))
;; Production 295: ((non_empty_argument_list) (non_empty_argument_list "," argument))
;; Production 296: ((clone_argument_list) ("(" ")"))
;; Production 297: ((clone_argument_list) ("(" non_empty_clone_argument_list possible_comma ")"))
;; Production 298: ((clone_argument_list) ("(" expr "," ")"))
;; Production 299: ((clone_argument_list) ("(" T_ELLIPSIS ")"))
;; Production 300: ((non_empty_clone_argument_list) (expr "," argument))
;; Production 301: ((non_empty_clone_argument_list) (argument_no_expr))
;; Production 302: ((non_empty_clone_argument_list) (non_empty_clone_argument_list "," argument))
;; Production 303: ((argument_no_expr) (identifier ":" expr))
;; Production 304: ((argument_no_expr) (T_ELLIPSIS expr))
;; Production 305: ((argument) (expr))
;; Production 306: ((argument) (argument_no_expr))
;; Production 307: ((global_var_list) (global_var_list "," global_var))
;; Production 308: ((global_var_list) (global_var))
;; Production 309: ((global_var) (simple_variable))
;; Production 310: ((static_var_list) (static_var_list "," static_var))
;; Production 311: ((static_var_list) (static_var))
;; Production 312: ((static_var) (T_VARIABLE))
;; Production 313: ((static_var) (T_VARIABLE "=" expr))
;; Production 314: ((class_statement_list) (class_statement_list class_statement))
;; Production 315: ((class_statement_list) (%empty))
;; Production 316: ((attributed_class_statement) (property_modifiers optional_type_without_static property_list ";"))
;; Production 317: ((attributed_class_statement) (property_modifiers optional_type_without_static hooked_property))
;; Production 318: ((attributed_class_statement) (class_const_modifiers T_CONST class_const_list ";"))
;; Production 319: ((attributed_class_statement) (class_const_modifiers T_CONST type_expr class_const_list ";"))
;; Production 320: ((attributed_class_statement) (method_modifiers function returns_ref identifier backup_doc_comment "(" parameter_list ")" return_type backup_fn_flags method_body backup_fn_flags))
;; Production 321: ((attributed_class_statement) (enum_case))
;; Production 322: ((class_statement) (attributed_class_statement))
;; Production 323: ((class_statement) (attributes attributed_class_statement))
;; Production 324: ((class_statement) (T_USE class_name_list trait_adaptations))
;; Production 325: ((class_name_list) (class_name))
;; Production 326: ((class_name_list) (class_name_list "," class_name))
;; Production 327: ((trait_adaptations) (";"))
;; Production 328: ((trait_adaptations) ("{" "}"))
;; Production 329: ((trait_adaptations) ("{" trait_adaptation_list "}"))
;; Production 330: ((trait_adaptation_list) (trait_adaptation))
;; Production 331: ((trait_adaptation_list) (trait_adaptation_list trait_adaptation))
;; Production 332: ((trait_adaptation) (trait_precedence ";"))
;; Production 333: ((trait_adaptation) (trait_alias ";"))
;; Production 334: ((trait_precedence) (absolute_trait_method_reference T_INSTEADOF class_name_list))
;; Production 335: ((trait_alias) (trait_method_reference T_AS T_STRING))
;; Production 336: ((trait_alias) (trait_method_reference T_AS reserved_non_modifiers))
;; Production 337: ((trait_alias) (trait_method_reference T_AS member_modifier identifier))
;; Production 338: ((trait_alias) (trait_method_reference T_AS member_modifier))
;; Production 339: ((trait_method_reference) (identifier))
;; Production 340: ((trait_method_reference) (absolute_trait_method_reference))
;; Production 341: ((absolute_trait_method_reference) (class_name T_PAAMAYIM_NEKUDOTAYIM identifier))
;; Production 342: ((method_body) (";"))
;; Production 343: ((method_body) ("{" inner_statement_list "}"))
;; Production 344: ((property_modifiers) (non_empty_member_modifiers))
;; Production 345: ((property_modifiers) (T_VAR))
;; Production 346: ((method_modifiers) (%empty))
;; Production 347: ((method_modifiers) (non_empty_member_modifiers))
;; Production 348: ((class_const_modifiers) (%empty))
;; Production 349: ((class_const_modifiers) (non_empty_member_modifiers))
;; Production 350: ((non_empty_member_modifiers) (member_modifier))
;; Production 351: ((non_empty_member_modifiers) (non_empty_member_modifiers member_modifier))
;; Production 352: ((member_modifier) (T_PUBLIC))
;; Production 353: ((member_modifier) (T_PROTECTED))
;; Production 354: ((member_modifier) (T_PRIVATE))
;; Production 355: ((member_modifier) (T_PUBLIC_SET))
;; Production 356: ((member_modifier) (T_PROTECTED_SET))
;; Production 357: ((member_modifier) (T_PRIVATE_SET))
;; Production 358: ((member_modifier) (T_STATIC))
;; Production 359: ((member_modifier) (T_ABSTRACT))
;; Production 360: ((member_modifier) (T_FINAL))
;; Production 361: ((member_modifier) (T_READONLY))
;; Production 362: ((property_list) (property_list "," property))
;; Production 363: ((property_list) (property))
;; Production 364: ((property) (T_VARIABLE backup_doc_comment))
;; Production 365: ((property) (T_VARIABLE "=" expr backup_doc_comment))
;; Production 366: ((hooked_property) (T_VARIABLE backup_doc_comment "{" property_hook_list "}"))
;; Production 367: ((hooked_property) (T_VARIABLE "=" expr backup_doc_comment "{" property_hook_list "}"))
;; Production 368: ((property_hook_list) (%empty))
;; Production 369: ((property_hook_list) (property_hook_list property_hook))
;; Production 370: ((property_hook_list) (property_hook_list attributes property_hook))
;; Production 371: ((optional_property_hook_list) (%empty))
;; Production 372: ((optional_property_hook_list) ("{" property_hook_list "}"))
;; Production 373: ((property_hook_modifiers) (%empty))
;; Production 374: ((property_hook_modifiers) (non_empty_member_modifiers))
;; Production 375: ((property_hook) (property_hook_modifiers returns_ref T_STRING backup_doc_comment optional_parameter_list backup_fn_flags property_hook_body backup_fn_flags))
;; Production 376: ((property_hook_body) (";"))
;; Production 377: ((property_hook_body) ("{" inner_statement_list "}"))
;; Production 378: ((property_hook_body) (T_DOUBLE_ARROW expr ";"))
;; Production 379: ((optional_parameter_list) (%empty))
;; Production 380: ((optional_parameter_list) ("(" parameter_list ")"))
;; Production 381: ((class_const_list) (class_const_list "," class_const_decl))
;; Production 382: ((class_const_list) (class_const_decl))
;; Production 383: ((class_const_decl) (T_STRING "=" expr backup_doc_comment))
;; Production 384: ((class_const_decl) (semi_reserved "=" expr backup_doc_comment))
;; Production 385: ((const_decl) (T_STRING "=" expr backup_doc_comment))
;; Production 386: ((echo_expr_list) (echo_expr_list "," echo_expr))
;; Production 387: ((echo_expr_list) (echo_expr))
;; Production 388: ((echo_expr) (expr))
;; Production 389: ((for_cond_exprs) (%empty))
;; Production 390: ((for_cond_exprs) (non_empty_for_exprs "," expr))
;; Production 391: ((for_cond_exprs) (expr))
;; Production 392: ((for_exprs) (%empty))
;; Production 393: ((for_exprs) (non_empty_for_exprs))
;; Production 394: ((non_empty_for_exprs) (non_empty_for_exprs "," expr))
;; Production 395: ((non_empty_for_exprs) (non_empty_for_exprs "," T_VOID_CAST expr))
;; Production 396: ((non_empty_for_exprs) (T_VOID_CAST expr))
;; Production 397: ((non_empty_for_exprs) (expr))
;; Production 398: ((anonymous_class) (anonymous_class_modifiers_optional T_CLASS ctor_arguments extends_from implements_list backup_doc_comment "{" class_statement_list "}"))
;; Production 399: ((new_dereferenceable) (T_NEW class_name_reference argument_list))
;; Production 400: ((new_dereferenceable) (T_NEW anonymous_class))
;; Production 401: ((new_dereferenceable) (T_NEW attributes anonymous_class))
;; Production 402: ((new_non_dereferenceable) (T_NEW class_name_reference))
;; Production 403: ((expr) (variable))
;; Production 404: ((expr) (T_LIST "(" array_pair_list ")" "=" expr))
;; Production 405: ((expr) ("[" array_pair_list "]" "=" expr))
;; Production 406: ((expr) (variable "=" expr))
;; Production 407: ((expr) (variable "=" ampersand variable))
;; Production 408: ((expr) (T_CLONE clone_argument_list))
;; Production 409: ((expr) (T_CLONE expr))
;; Production 410: ((expr) (variable T_PLUS_EQUAL expr))
;; Production 411: ((expr) (variable T_MINUS_EQUAL expr))
;; Production 412: ((expr) (variable T_MUL_EQUAL expr))
;; Production 413: ((expr) (variable T_POW_EQUAL expr))
;; Production 414: ((expr) (variable T_DIV_EQUAL expr))
;; Production 415: ((expr) (variable T_CONCAT_EQUAL expr))
;; Production 416: ((expr) (variable T_MOD_EQUAL expr))
;; Production 417: ((expr) (variable T_AND_EQUAL expr))
;; Production 418: ((expr) (variable T_OR_EQUAL expr))
;; Production 419: ((expr) (variable T_XOR_EQUAL expr))
;; Production 420: ((expr) (variable T_SL_EQUAL expr))
;; Production 421: ((expr) (variable T_SR_EQUAL expr))
;; Production 422: ((expr) (variable T_COALESCE_EQUAL expr))
;; Production 423: ((expr) (variable T_INC))
;; Production 424: ((expr) (T_INC variable))
;; Production 425: ((expr) (variable T_DEC))
;; Production 426: ((expr) (T_DEC variable))
;; Production 427: ((expr) (expr T_BOOLEAN_OR expr))
;; Production 428: ((expr) (expr T_BOOLEAN_AND expr))
;; Production 429: ((expr) (expr T_LOGICAL_OR expr))
;; Production 430: ((expr) (expr T_LOGICAL_AND expr))
;; Production 431: ((expr) (expr T_LOGICAL_XOR expr))
;; Production 432: ((expr) (expr "|" expr))
;; Production 433: ((expr) (expr T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG expr))
;; Production 434: ((expr) (expr T_AMPERSAND_FOLLOWED_BY_VAR_OR_VARARG expr))
;; Production 435: ((expr) (expr "^" expr))
;; Production 436: ((expr) (expr "." expr))
;; Production 437: ((expr) (expr "+" expr))
;; Production 438: ((expr) (expr "-" expr))
;; Production 439: ((expr) (expr "*" expr))
;; Production 440: ((expr) (expr T_POW expr))
;; Production 441: ((expr) (expr "/" expr))
;; Production 442: ((expr) (expr "%" expr))
;; Production 443: ((expr) (expr T_SL expr))
;; Production 444: ((expr) (expr T_SR expr))
;; Production 445: ((expr) ("+" expr))
;; Production 446: ((expr) ("-" expr))
;; Production 447: ((expr) ("!" expr))
;; Production 448: ((expr) ("~" expr))
;; Production 449: ((expr) (expr T_IS_IDENTICAL expr))
;; Production 450: ((expr) (expr T_IS_NOT_IDENTICAL expr))
;; Production 451: ((expr) (expr T_IS_EQUAL expr))
;; Production 452: ((expr) (expr T_IS_NOT_EQUAL expr))
;; Production 453: ((expr) (expr T_PIPE expr))
;; Production 454: ((expr) (expr "<" expr))
;; Production 455: ((expr) (expr T_IS_SMALLER_OR_EQUAL expr))
;; Production 456: ((expr) (expr ">" expr))
;; Production 457: ((expr) (expr T_IS_GREATER_OR_EQUAL expr))
;; Production 458: ((expr) (expr T_SPACESHIP expr))
;; Production 459: ((expr) (expr T_INSTANCEOF class_name_reference))
;; Production 460: ((expr) ("(" expr ")"))
;; Production 461: ((expr) (new_dereferenceable))
;; Production 462: ((expr) (new_non_dereferenceable))
;; Production 463: ((expr) (expr "?" expr ":" expr))
;; Production 464: ((expr) (expr "?" ":" expr))
;; Production 465: ((expr) (expr T_COALESCE expr))
;; Production 466: ((expr) (internal_functions_in_yacc))
;; Production 467: ((expr) (T_INT_CAST expr))
;; Production 468: ((expr) (T_DOUBLE_CAST expr))
;; Production 469: ((expr) (T_STRING_CAST expr))
;; Production 470: ((expr) (T_ARRAY_CAST expr))
;; Production 471: ((expr) (T_OBJECT_CAST expr))
;; Production 472: ((expr) (T_BOOL_CAST expr))
;; Production 473: ((expr) (T_UNSET_CAST expr))
;; Production 474: ((expr) (T_EXIT ctor_arguments))
;; Production 475: ((expr) ("@" expr))
;; Production 476: ((expr) (scalar))
;; Production 477: ((expr) ("`" backticks_expr "`"))
;; Production 478: ((expr) (T_PRINT expr))
;; Production 479: ((expr) (T_YIELD))
;; Production 480: ((expr) (T_YIELD expr))
;; Production 481: ((expr) (T_YIELD expr T_DOUBLE_ARROW expr))
;; Production 482: ((expr) (T_YIELD_FROM expr))
;; Production 483: ((expr) (T_THROW expr))
;; Production 484: ((expr) (inline_function))
;; Production 485: ((expr) (attributes inline_function))
;; Production 486: ((expr) (T_STATIC inline_function))
;; Production 487: ((expr) (attributes T_STATIC inline_function))
;; Production 488: ((expr) (match))
;; Production 489: ((inline_function) (function returns_ref backup_doc_comment "(" parameter_list ")" lexical_vars return_type backup_fn_flags "{" inner_statement_list "}" backup_fn_flags))
;; Production 490: ((inline_function) (fn returns_ref backup_doc_comment "(" parameter_list ")" return_type T_DOUBLE_ARROW backup_fn_flags backup_lex_pos expr backup_fn_flags))
;; Production 491: ((fn) (T_FN))
;; Production 492: ((function) (T_FUNCTION))
;; Production 493: ((backup_doc_comment) (%empty))
;; Production 494: ((backup_fn_flags) (%empty))
;; Production 495: ((backup_lex_pos) (%empty))
;; Production 496: ((returns_ref) (%empty))
;; Production 497: ((returns_ref) (ampersand))
;; Production 498: ((lexical_vars) (%empty))
;; Production 499: ((lexical_vars) (T_USE "(" lexical_var_list possible_comma ")"))
;; Production 500: ((lexical_var_list) (lexical_var_list "," lexical_var))
;; Production 501: ((lexical_var_list) (lexical_var))
;; Production 502: ((lexical_var) (T_VARIABLE))
;; Production 503: ((lexical_var) (ampersand T_VARIABLE))
;; Production 504: ((function_call) (name argument_list))
;; Production 505: ((function_call) (T_READONLY argument_list))
;; Production 506: ((function_call) (class_name T_PAAMAYIM_NEKUDOTAYIM member_name argument_list))
;; Production 507: ((function_call) (variable_class_name T_PAAMAYIM_NEKUDOTAYIM member_name argument_list))
;; Production 508: ((function_call) (callable_expr argument_list))
;; Production 509: ((class_name) (T_STATIC))
;; Production 510: ((class_name) (name))
;; Production 511: ((class_name_reference) (class_name))
;; Production 512: ((class_name_reference) (new_variable))
;; Production 513: ((class_name_reference) ("(" expr ")"))
;; Production 514: ((backticks_expr) (%empty))
;; Production 515: ((backticks_expr) (T_ENCAPSED_AND_WHITESPACE))
;; Production 516: ((backticks_expr) (encaps_list))
;; Production 517: ((ctor_arguments) (%empty))
;; Production 518: ((ctor_arguments) (argument_list))
;; Production 519: ((dereferenceable_scalar) (T_ARRAY "(" array_pair_list ")"))
;; Production 520: ((dereferenceable_scalar) ("[" array_pair_list "]"))
;; Production 521: ((dereferenceable_scalar) (T_CONSTANT_ENCAPSED_STRING))
;; Production 522: ((dereferenceable_scalar) ("\"" encaps_list "\""))
;; Production 523: ((scalar) (T_LNUMBER))
;; Production 524: ((scalar) (T_DNUMBER))
;; Production 525: ((scalar) (T_START_HEREDOC T_ENCAPSED_AND_WHITESPACE T_END_HEREDOC))
;; Production 526: ((scalar) (T_START_HEREDOC T_END_HEREDOC))
;; Production 527: ((scalar) (T_START_HEREDOC encaps_list T_END_HEREDOC))
;; Production 528: ((scalar) (dereferenceable_scalar))
;; Production 529: ((scalar) (constant))
;; Production 530: ((scalar) (class_constant))
;; Production 531: ((constant) (name))
;; Production 532: ((constant) (T_LINE))
;; Production 533: ((constant) (T_FILE))
;; Production 534: ((constant) (T_DIR))
;; Production 535: ((constant) (T_TRAIT_C))
;; Production 536: ((constant) (T_METHOD_C))
;; Production 537: ((constant) (T_FUNC_C))
;; Production 538: ((constant) (T_PROPERTY_C))
;; Production 539: ((constant) (T_NS_C))
;; Production 540: ((constant) (T_CLASS_C))
;; Production 541: ((class_constant) (class_name T_PAAMAYIM_NEKUDOTAYIM identifier))
;; Production 542: ((class_constant) (variable_class_name T_PAAMAYIM_NEKUDOTAYIM identifier))
;; Production 543: ((class_constant) (class_name T_PAAMAYIM_NEKUDOTAYIM "{" expr "}"))
;; Production 544: ((class_constant) (variable_class_name T_PAAMAYIM_NEKUDOTAYIM "{" expr "}"))
;; Production 545: ((optional_expr) (%empty))
;; Production 546: ((optional_expr) (expr))
;; Production 547: ((variable_class_name) (fully_dereferenceable))
;; Production 548: ((fully_dereferenceable) (variable))
;; Production 549: ((fully_dereferenceable) ("(" expr ")"))
;; Production 550: ((fully_dereferenceable) (dereferenceable_scalar))
;; Production 551: ((fully_dereferenceable) (class_constant))
;; Production 552: ((fully_dereferenceable) (new_dereferenceable))
;; Production 553: ((array_object_dereferenceable) (fully_dereferenceable))
;; Production 554: ((array_object_dereferenceable) (constant))
;; Production 555: ((callable_expr) (callable_variable))
;; Production 556: ((callable_expr) ("(" expr ")"))
;; Production 557: ((callable_expr) (dereferenceable_scalar))
;; Production 558: ((callable_expr) (new_dereferenceable))
;; Production 559: ((callable_variable) (simple_variable))
;; Production 560: ((callable_variable) (array_object_dereferenceable "[" optional_expr "]"))
;; Production 561: ((callable_variable) (array_object_dereferenceable T_OBJECT_OPERATOR property_name argument_list))
;; Production 562: ((callable_variable) (array_object_dereferenceable T_NULLSAFE_OBJECT_OPERATOR property_name argument_list))
;; Production 563: ((callable_variable) (function_call))
;; Production 564: ((variable) (callable_variable))
;; Production 565: ((variable) (static_member))
;; Production 566: ((variable) (array_object_dereferenceable T_OBJECT_OPERATOR property_name))
;; Production 567: ((variable) (array_object_dereferenceable T_NULLSAFE_OBJECT_OPERATOR property_name))
;; Production 568: ((simple_variable) (T_VARIABLE))
;; Production 569: ((simple_variable) ("$" "{" expr "}"))
;; Production 570: ((simple_variable) ("$" simple_variable))
;; Production 571: ((static_member) (class_name T_PAAMAYIM_NEKUDOTAYIM simple_variable))
;; Production 572: ((static_member) (variable_class_name T_PAAMAYIM_NEKUDOTAYIM simple_variable))
;; Production 573: ((new_variable) (simple_variable))
;; Production 574: ((new_variable) (new_variable "[" optional_expr "]"))
;; Production 575: ((new_variable) (new_variable T_OBJECT_OPERATOR property_name))
;; Production 576: ((new_variable) (new_variable T_NULLSAFE_OBJECT_OPERATOR property_name))
;; Production 577: ((new_variable) (class_name T_PAAMAYIM_NEKUDOTAYIM simple_variable))
;; Production 578: ((new_variable) (new_variable T_PAAMAYIM_NEKUDOTAYIM simple_variable))
;; Production 579: ((member_name) (identifier))
;; Production 580: ((member_name) ("{" expr "}"))
;; Production 581: ((member_name) (simple_variable))
;; Production 582: ((property_name) (T_STRING))
;; Production 583: ((property_name) ("{" expr "}"))
;; Production 584: ((property_name) (simple_variable))
;; Production 585: ((array_pair_list) (non_empty_array_pair_list))
;; Production 586: ((possible_array_pair) (%empty))
;; Production 587: ((possible_array_pair) (array_pair))
;; Production 588: ((non_empty_array_pair_list) (non_empty_array_pair_list "," possible_array_pair))
;; Production 589: ((non_empty_array_pair_list) (possible_array_pair))
;; Production 590: ((array_pair) (expr T_DOUBLE_ARROW expr))
;; Production 591: ((array_pair) (expr))
;; Production 592: ((array_pair) (expr T_DOUBLE_ARROW ampersand variable))
;; Production 593: ((array_pair) (ampersand variable))
;; Production 594: ((array_pair) (T_ELLIPSIS expr))
;; Production 595: ((array_pair) (expr T_DOUBLE_ARROW T_LIST "(" array_pair_list ")"))
;; Production 596: ((array_pair) (T_LIST "(" array_pair_list ")"))
;; Production 597: ((encaps_list) (encaps_list encaps_var))
;; Production 598: ((encaps_list) (encaps_list T_ENCAPSED_AND_WHITESPACE))
;; Production 599: ((encaps_list) (encaps_var))
;; Production 600: ((encaps_list) (T_ENCAPSED_AND_WHITESPACE encaps_var))
;; Production 601: ((encaps_var) (T_VARIABLE))
;; Production 602: ((encaps_var) (T_VARIABLE "[" encaps_var_offset "]"))
;; Production 603: ((encaps_var) (T_VARIABLE T_OBJECT_OPERATOR T_STRING))
;; Production 604: ((encaps_var) (T_VARIABLE T_NULLSAFE_OBJECT_OPERATOR T_STRING))
;; Production 605: ((encaps_var) (T_DOLLAR_OPEN_CURLY_BRACES expr "}"))
;; Production 606: ((encaps_var) (T_DOLLAR_OPEN_CURLY_BRACES T_STRING_VARNAME "}"))
;; Production 607: ((encaps_var) (T_DOLLAR_OPEN_CURLY_BRACES T_STRING_VARNAME "[" expr "]" "}"))
;; Production 608: ((encaps_var) (T_CURLY_OPEN variable "}"))
;; Production 609: ((encaps_var_offset) (T_STRING))
;; Production 610: ((encaps_var_offset) (T_NUM_STRING))
;; Production 611: ((encaps_var_offset) ("-" T_NUM_STRING))
;; Production 612: ((encaps_var_offset) (T_VARIABLE))
;; Production 613: ((internal_functions_in_yacc) (T_ISSET "(" isset_variables possible_comma ")"))
;; Production 614: ((internal_functions_in_yacc) (T_EMPTY "(" expr ")"))
;; Production 615: ((internal_functions_in_yacc) (T_INCLUDE expr))
;; Production 616: ((internal_functions_in_yacc) (T_INCLUDE_ONCE expr))
;; Production 617: ((internal_functions_in_yacc) (T_EVAL "(" expr ")"))
;; Production 618: ((internal_functions_in_yacc) (T_REQUIRE expr))
;; Production 619: ((internal_functions_in_yacc) (T_REQUIRE_ONCE expr))
;; Production 620: ((isset_variables) (isset_variable))
;; Production 621: ((isset_variables) (isset_variables "," isset_variable))
;; Production 622: ((isset_variable) (expr))

;;; Code:


(require 'phps-mode-parser)

(defvar-local
  phps-mode-parser-sdt-bookkeeping
  (make-hash-table :test 'equal)
  "Bookkeeping of symbol references.")

(defvar-local
  phps-mode-parser-sdt-symbol-table-index
  0
  "Symbol table index.")

(defvar-local
  phps-mode-parser-sdt-symbol-table
  (make-hash-table :test 'equal)
  "Symbol table of parse, symbol ID => (list URI start end)")

(defvar-local
  phps-mode-parser-sdt-symbol-table-by-uri
  (make-hash-table :test 'equal)
  "Symbol table of parse, symbol URI => list of symbol IDs.")

(defvar-local
  phps-mode-parser-sdt-symbol-imenu
  nil
  "Imenu for symbols of parse.")

(defvar-local
  phps-mode-parser-sdt-symbol-imenu--table
  nil
  "Symbols inside namespaces.")

(defvar-local
  phps-mode-parser-sdt-symbol-imenu--stack
  nil
  "Current imenu namespace.")

(defvar-local
  phps-mode-parser-sdt-symbol-imenu--namespace
  nil
  "Current imenu namespace.")

(defvar-local
  phps-mode-parser-sdt--bookkeeping-namespace
  nil
  "Current bookkeeping namespace.")

(defvar-local
  phps-mode-parser-sdt--bookkeeping-symbol-stack
  nil
  "Current bookkeeping symbol stack.")

(defvar-local
  phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack
  nil
  "Current bookkeeping assignment symbol stack.")

(defvar-local
  phps-mode-parser-sdt--bookkeeping-anonymous-function-count
  nil
  "Count of anonymous functions.")

(defvar-local
  phps-mode-parser-sdt--bookkeeping-arrow-function-count
  nil
  "Count of arrow functions.")

(defvar
  phps-mode-parser-sdt--bookkeeping--superglobal-variable-p
  #s(hash-table size 12 test equal rehash-size 1.5 rehash-threshold 0.8125 data ("$_GET" 1 "$_POST" 1 "$_COOKIE" 1 "$_SESSION" 1 "$_REQUEST" 1 "$GLOBALS" 1 "$_SERVER" 1 "$_FILES" 1 "$_ENV" 1 "$argc" 1 "$argv" 1 "$http_​response_​header" 1))
  "Hash-table of super-global variables.")

(defun phps-mode-parser-sdt--get-symbol-uri (name scope)
  "Get URI from symbol NAME in SCOPE."
  (if (gethash
       name
       phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
      (list
       name
       (list 'namespace nil 'class nil 'trait nil 'interface nil 'function nil 'superglobal t 'object-operator nil 'static-member nil))
    (let ((potential-uris (list ""))
          (scope-namespace)
          (scope-class)
          (scope-trait)
          (scope-interface)
          (scope-function)
          (scope-object-operator)
          (scope-static-member))
      (when scope
        (let ((scope-count (length scope))
              (scope-index 0))
          (while (< scope-index scope-count)
            (let ((item (nth scope-index scope))
                  (next-scope)
                  (next-scope-type)
                  (next-scope-is-global)
                  (next-scope-is-this-object-operator)
                  (next-scope-is-self-static-member-operator))

              ;; Should add one scope look-ahead to determine if we should
              ;; ignore function scope before a $this-> or self:: or static:: operator
              (when (< scope-index (1- scope-count))
                (let ((next-scope-index (1+ scope-index)))
                  (setq next-scope (nth next-scope-index scope))
                  (setq next-scope-type (car next-scope))

                  ;; When next scope is arrow function, ignore it
                  (while (and
                          (equal next-scope-type 'arrow-function)
                          (< next-scope-index (1- scope-count)))
                    (setq next-scope-index (1+ next-scope-index))
                    (setq next-scope (nth next-scope-index scope))
                    (setq next-scope-type (car next-scope)))

                  (cond
                   ((equal next-scope-type 'global)
                    (setq next-scope-is-global t))
                   ((equal next-scope-type 'object-operator)
                    (setq scope-object-operator (car (cdr next-scope)))
                    (let ((downcased-scope-name (downcase (car (cdr next-scope)))))
                      (when (string= downcased-scope-name "$this")
                        (setq next-scope-is-this-object-operator t))))
                   ((equal next-scope-type 'static-member)
                    (setq scope-static-member t)
                    (let ((downcased-scope-name (downcase (plist-get (car (cdr next-scope)) 'name))))
                      (when (or
                             (string= downcased-scope-name "self")
                             (string= downcased-scope-name "static"))
                        (when (equal next-scope-index (1+ scope-index))
                          (let ((potential-uri-count (length potential-uris))
                                (potential-uri-index 0))
                            (while (< potential-uri-index potential-uri-count)
                              (setf
                               (nth potential-uri-index potential-uris)
                               (format "static %s" (nth potential-uri-index potential-uris)))
                              (setq potential-uri-index (1+ potential-uri-index)))))
                        (setq next-scope-is-self-static-member-operator t)))))))

              (let ((space-type (nth 0 item))
                    (space-name (nth 1 item)))
                (cond

                 ((equal space-type 'namespace)
                  (unless next-scope-is-global
                    (setq scope-namespace (list space-name (nth 2 item)))
                    (let ((potential-uri-count (length potential-uris))
                          (potential-uri-index 0))
                      (while (< potential-uri-index potential-uri-count)
                        (setf
                         (nth potential-uri-index potential-uris)
                         (format
                          "namespace %s %s"
                          space-name
                          (nth potential-uri-index potential-uris)))
                        (setq potential-uri-index (1+ potential-uri-index))))))

                 ((equal space-type 'class)
                  (unless next-scope-is-global
                    (setq scope-class (list space-name (nth 2 item)))
                    (let ((potential-uri-count (length potential-uris))
                          (potential-uri-index 0))
                      (while (< potential-uri-index potential-uri-count)
                        (setf
                         (nth potential-uri-index potential-uris)
                         (format
                          "class %s %s"
                          space-name
                          (nth potential-uri-index potential-uris)))
                        (setq potential-uri-index (1+ potential-uri-index))))))

                 ((equal space-type 'interface)
                  (unless next-scope-is-global
                    (setq scope-interface (list space-name (nth 2 item)))
                    (let ((potential-uri-count (length potential-uris))
                          (potential-uri-index 0))
                      (while (< potential-uri-index potential-uri-count)
                        (setf
                         (nth potential-uri-index potential-uris)
                         (format
                          "interface %s %s"
                          space-name
                          (nth potential-uri-index potential-uris)))
                        (setq potential-uri-index (1+ potential-uri-index))))))

                 ((equal space-type 'trait)
                  (unless next-scope-is-global
                    (setq scope-trait (list space-name (nth 2 item)))
                    (let ((potential-uri-count (length potential-uris))
                          (potential-uri-index 0))
                      (while (< potential-uri-index potential-uri-count)
                        (setf
                         (nth potential-uri-index potential-uris)
                         (format
                          "trait %s %s"
                          space-name
                          (nth potential-uri-index potential-uris)))
                        (setq potential-uri-index (1+ potential-uri-index))))))

                 ((equal space-type 'function)
                  (unless (or
                           next-scope-is-global
                           next-scope-is-this-object-operator
                           next-scope-is-self-static-member-operator)
                    (setq scope-function (list space-name (nth 2 item)))
                    (let ((potential-uri-count (length potential-uris))
                          (potential-uri-index 0))
                      (while (< potential-uri-index potential-uri-count)
                        (setf
                         (nth potential-uri-index potential-uris)
                         (format
                          "function %s %s"
                          space-name
                          (nth potential-uri-index potential-uris)))
                        (setq potential-uri-index (1+ potential-uri-index))))))

                 ((equal space-type 'anonymous-function)
                  (let ((potential-uri-count (length potential-uris))
                        (potential-uri-index 0))
                    (while (< potential-uri-index potential-uri-count)
                      (setf
                       (nth potential-uri-index potential-uris)
                       (format
                        "anonymous %s %s"
                        space-name
                        (nth potential-uri-index potential-uris)))
                      (setq potential-uri-index (1+ potential-uri-index)))))

                 ((equal space-type 'static)
                  (let ((potential-uri-count (length potential-uris))
                        (potential-uri-index 0))
                    (while (< potential-uri-index potential-uri-count)
                      (setf
                       (nth potential-uri-index potential-uris)
                       (format
                        "static %s"
                        (nth potential-uri-index potential-uris)))
                      (setq potential-uri-index (1+ potential-uri-index)))))

                 ((equal space-type 'arrow-function)
                  ;; branch of two alternative namespaces here
                  ;; one with and one without the arrow function scope
                  (let ((potential-uri-count (length potential-uris))
                        (potential-uri-index 0)
                        (new-potential-uris))
                    (while (< potential-uri-index potential-uri-count)
                      (push
                       (format
                        "arrow %s %s"
                        space-name
                        (nth potential-uri-index potential-uris))
                       new-potential-uris)
                      (setq potential-uri-index (1+ potential-uri-index)))
                    (setq potential-uris (append new-potential-uris potential-uris))
                    ;; (message "new-potential-uris: %S" new-potential-uris)
                    ;; (message "potential-uris: %S" potential-uris)
                    ))

                 ((equal space-type 'object-operator)
                  (setq scope-object-operator space-name))

                 ((equal space-type 'static-member)
                  (setq scope-static-member space-name))

                 )))
            (setq scope-index (1+ scope-index)))))

      (let ((potential-uri-count (length potential-uris))
            (potential-uri-index 0)
            (matching-uri))

        ;; Iterate potential-uris, select first match or if no match just return the first
        (while (and
                (< potential-uri-index potential-uri-count)
                (not matching-uri))
          (let ((potential-uri (nth potential-uri-index potential-uris)))
            (setq
             potential-uri
             (format
              "%sid %s"
              potential-uri
              name))
            (setf
             (nth potential-uri-index potential-uris)
             potential-uri)
            (when (gethash potential-uri phps-mode-parser-sdt-symbol-table-by-uri)
              (setq matching-uri potential-uri))
            (setq potential-uri-index (1+ potential-uri-index))))
        (if matching-uri
            (list
             matching-uri
             (list 'namespace scope-namespace 'class scope-class 'trait scope-trait 'interface scope-interface 'function scope-function 'superglobal nil 'object-operator scope-object-operator 'static-member scope-static-member))
          (list
           (nth 0 potential-uris)
           (list 'namespace scope-namespace 'class scope-class 'trait scope-trait 'interface scope-interface 'function scope-function 'superglobal nil 'object-operator scope-object-operator 'static-member scope-static-member)))))))

(defun phps-mode-parser-sdt--parse-top-statement ()
  "Parse latest top statement."
   ;; (message "phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack: %S" phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
  ;; (message "phps-mode-parser-sdt--bookkeeping-symbol-stack: %S" phps-mode-parser-sdt--bookkeeping-symbol-stack)

  ;; Add imenu class, trait, interface and functions here
  (when
      phps-mode-parser-sdt-symbol-imenu--namespace
    ;; (message "phps-mode-parser-sdt-symbol-imenu--namespace: %S" phps-mode-parser-sdt-symbol-imenu--namespace)
    (let ((imenu-nail (format "namespace %s" (nth 0 phps-mode-parser-sdt-symbol-imenu--namespace))))
      (unless
          (gethash
           imenu-nail
           phps-mode-parser-sdt-symbol-imenu--table)
        (puthash
         imenu-nail
         (make-hash-table :test 'equal)
         phps-mode-parser-sdt-symbol-imenu--table))))

    ;; (message "\nphps-mode-parser-sdt-symbol-imenu--stack: %S" phps-mode-parser-sdt-symbol-imenu--stack)
  (when phps-mode-parser-sdt-symbol-imenu--stack
    ;; Go through imenu stack and add new items to imenu index
    (let ((imenu-namespace
           phps-mode-parser-sdt-symbol-imenu--namespace))
      (dolist (imenu-scopes phps-mode-parser-sdt-symbol-imenu--stack)
        (let ((imenu-class)
              (imenu-trait)
              (imenu-interface)
              (imenu-function))
          (dolist (imenu-scope imenu-scopes)
            (let ((imenu-item-type (nth 0 imenu-scope))
                  (imenu-item-name (nth 1 imenu-scope))
                  (imenu-item-start (nth 2 imenu-scope)))
              (cond
               ((equal imenu-item-type 'namespace)
                (setq imenu-namespace (list imenu-item-name imenu-item-start)))
               ((equal imenu-item-type 'class)
                (setq imenu-class (list imenu-item-name imenu-item-start)))
               ((equal imenu-item-type 'interface)
                (setq imenu-interface (list imenu-item-name imenu-item-start)))
               ((equal imenu-item-type 'trait)
                (setq imenu-trait (list imenu-item-name imenu-item-start)))
               ((equal imenu-item-type 'function)
                (setq imenu-function (list imenu-item-name imenu-item-start))))))

          ;; (message "\nimenu-namespace: %S" imenu-namespace)
          ;; (message "imenu-class: %S" imenu-class)
          ;; (message "imenu-trait: %S" imenu-trait)
          ;; (message "imenu-interface: %S" imenu-interface)
          ;; (message "imenu-function: %S" imenu-function)

          (cond

           (imenu-namespace
            (let ((imenu-nail (format "namespace %s" (nth 0 imenu-namespace))))
              (unless (gethash imenu-nail phps-mode-parser-sdt-symbol-imenu--table)
                (let ((imenu-object (make-hash-table :test 'equal)))
                  (puthash 'declaration (nth 1 imenu-namespace) imenu-object)
                  (puthash imenu-nail imenu-object phps-mode-parser-sdt-symbol-imenu--table)))
              (cond

               (imenu-class
                (let ((imenu-nail2 (format "class %s" (nth 0 imenu-class))))
                  (unless
                      (gethash
                       imenu-nail2
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))
                    (let ((imenu-object (make-hash-table :test 'equal)))
                      (puthash 'declaration (nth 1 imenu-class) imenu-object)
                      (puthash
                       imenu-nail2
                       imenu-object
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))))
                  (when imenu-function
                    (let ((imenu-nail3 (format "function %s" (nth 0 imenu-function))))
                      (unless
                          (gethash
                           imenu-nail3
                           (gethash
                            imenu-nail2
                            (gethash
                             imenu-nail
                             phps-mode-parser-sdt-symbol-imenu--table)))
                        (let ((imenu-object (make-hash-table :test 'equal)))
                          (puthash 'declaration (nth 1 imenu-function) imenu-object)
                          (puthash
                           imenu-nail3
                           imenu-object
                           (gethash
                            imenu-nail2
                            (gethash
                             imenu-nail
                             phps-mode-parser-sdt-symbol-imenu--table)))))))))

               (imenu-trait
                (let ((imenu-nail2 (format "trait %s" (nth 0 imenu-trait))))
                  (unless
                      (gethash
                       imenu-nail2
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))
                    (let ((imenu-object (make-hash-table :test 'equal)))
                      (puthash 'declaration (nth 1 imenu-trait) imenu-object)
                      (puthash
                       imenu-nail2
                       imenu-object
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))))
                  (when imenu-function
                    (let ((imenu-nail3 (format "function %s" (nth 0 imenu-function))))
                      (unless
                          (gethash
                           imenu-nail3
                           (gethash
                            imenu-nail2
                            (gethash
                             imenu-nail
                             phps-mode-parser-sdt-symbol-imenu--table)))
                        (let ((imenu-object (make-hash-table :test 'equal)))
                          (puthash 'declaration (nth 1 imenu-function) imenu-object)
                          (puthash
                           imenu-nail3
                           imenu-object
                           (gethash
                            imenu-nail2
                            (gethash
                             imenu-nail
                             phps-mode-parser-sdt-symbol-imenu--table)))))))))

               (imenu-interface
                (let ((imenu-nail2 (format "interface %s" (nth 0 imenu-interface))))
                  (unless
                      (gethash
                       imenu-nail2
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))
                    (let ((imenu-object (make-hash-table :test 'equal)))
                      (puthash 'declaration (nth 1 imenu-interface) imenu-object)
                      (puthash
                       imenu-nail2
                       imenu-object
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))))
                  (when imenu-function
                    (let ((imenu-nail3 (format "function %s" (nth 0 imenu-function))))
                      (unless
                          (gethash
                           imenu-nail3
                           (gethash
                            imenu-nail2
                            (gethash
                             imenu-nail
                             phps-mode-parser-sdt-symbol-imenu--table)))
                        (let ((imenu-object (make-hash-table :test 'equal)))
                          (puthash 'declaration (nth 1 imenu-function) imenu-object)
                          (puthash
                           imenu-nail3
                           imenu-object
                           (gethash
                            imenu-nail2
                            (gethash
                             imenu-nail
                             phps-mode-parser-sdt-symbol-imenu--table)))))))))

               (imenu-function
                (let ((imenu-nail2 (format "function %s" (nth 0 imenu-function))))
                  (unless
                      (gethash
                       imenu-nail2
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))
                    (let ((imenu-object (make-hash-table :test 'equal)))
                      (puthash 'declaration (nth 1 imenu-function) imenu-object)
                      (puthash
                       imenu-nail2
                       imenu-object
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))))
                  (when imenu-function
                    (let ((imenu-nail3 (format "function %s" (nth 0 imenu-function))))
                      (unless
                          (gethash
                           imenu-nail3
                           (gethash
                            imenu-nail2
                            (gethash
                             imenu-nail
                             phps-mode-parser-sdt-symbol-imenu--table)))
                        (let ((imenu-object (make-hash-table :test 'equal)))
                          (puthash 'declaration (nth 1 imenu-function) imenu-object)
                          (puthash
                           imenu-nail3
                           imenu-object
                           (gethash
                            imenu-nail2
                            (gethash
                             imenu-nail
                             phps-mode-parser-sdt-symbol-imenu--table)))))))))

               )))

           (imenu-class
            (let ((imenu-nail (format "class %s" (nth 0 imenu-class))))
              (unless
                  (gethash
                   imenu-nail
                   phps-mode-parser-sdt-symbol-imenu--table)
                (let ((imenu-object (make-hash-table :test 'equal)))
                  (puthash 'declaration (nth 1 imenu-class) imenu-object)
                  (puthash
                   imenu-nail
                   imenu-object
                   phps-mode-parser-sdt-symbol-imenu--table)))
              (when imenu-function
                (let ((imenu-nail2 (format "function %s" (nth 0 imenu-function))))
                  (unless
                      (gethash
                       imenu-nail2
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))
                    (let ((imenu-object (make-hash-table :test 'equal)))
                      (puthash 'declaration (nth 1 imenu-function) imenu-object)
                      (puthash
                       imenu-nail2
                       imenu-object
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))))))))

           (imenu-trait
            (let ((imenu-nail (format "trait %s" (nth 0 imenu-trait))))
              (unless
                  (gethash
                   imenu-nail
                   phps-mode-parser-sdt-symbol-imenu--table)
                (let ((imenu-object (make-hash-table :test 'equal)))
                  (puthash 'declaration (nth 1 imenu-trait) imenu-object)
                  (puthash
                   imenu-nail
                   imenu-object
                   phps-mode-parser-sdt-symbol-imenu--table)))
              (when imenu-function
                (let ((imenu-nail2 (format "function %s" (nth 0 imenu-function))))
                  (unless
                      (gethash
                       imenu-nail2
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))
                    (let ((imenu-object (make-hash-table :test 'equal)))
                      (puthash 'declaration (nth 1 imenu-function) imenu-object)
                      (puthash
                       imenu-nail2
                       imenu-object
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))))))))

           (imenu-interface
            (let ((imenu-nail (format "interface %s" (nth 0 imenu-interface))))
              (unless
                  (gethash
                   imenu-nail
                   phps-mode-parser-sdt-symbol-imenu--table)
                (let ((imenu-object (make-hash-table :test 'equal)))
                  (puthash 'declaration (nth 1 imenu-interface) imenu-object)
                  (puthash
                   imenu-nail
                   imenu-object
                   phps-mode-parser-sdt-symbol-imenu--table)))
              (when imenu-function
                (let ((imenu-nail2 (format "function %s" (nth 0 imenu-function))))
                  (unless
                      (gethash
                       imenu-nail2
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))
                    (let ((imenu-object (make-hash-table :test 'equal)))
                      (puthash 'declaration (nth 1 imenu-function) imenu-object)
                      (puthash
                       imenu-nail2
                       imenu-object
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))))))))

           (imenu-function
            (let ((imenu-nail (format "function %s" (nth 0 imenu-function))))
              (unless
                  (gethash
                   imenu-nail
                   phps-mode-parser-sdt-symbol-imenu--table)
                (let ((imenu-object (make-hash-table :test 'equal)))
                  (puthash 'declaration (nth 1 imenu-function) imenu-object)
                  (puthash
                   imenu-nail
                   imenu-object
                   phps-mode-parser-sdt-symbol-imenu--table)))))))))
    (setq phps-mode-parser-sdt-symbol-imenu--stack nil))

    ;; (message "phps-mode-parser-sdt-symbol-imenu--table: %S" phps-mode-parser-sdt-symbol-imenu--table)

  ;; Parse bookkeeping writes and reads at every statement terminus
  (when phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack
    ;; Declare variables
    (dolist (
             symbol-list
             (reverse phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))
      (let* ((symbol-name (car symbol-list))
             (symbol-scope (car (cdr symbol-list)))
             (symbol-start (car (cdr (cdr symbol-list))))
             (symbol-end (car (cdr (cdr (cdr symbol-list)))))
             (symbol-uri-object
              (phps-mode-parser-sdt--get-symbol-uri
               symbol-name
               symbol-scope))
             (symbol-uri (car symbol-uri-object))
             (symbol-namespace)
             (symbol-class)
             (symbol-interface)
             (symbol-trait)
             (symbol-function)
             (symbol-is-superglobal)
             (symbol-is-this (string= (downcase symbol-name) "$this")))

        ;; Collect namespace, class, interface, trait and function here
        (when (nth 1 (nth 1 symbol-uri-object))
          (setq symbol-namespace (car (nth 1 (nth 1 symbol-uri-object)))))
        (when (nth 3 (nth 1 symbol-uri-object))
          (setq symbol-class (car (nth 3 (nth 1 symbol-uri-object)))))
        (when (nth 5 (nth 1 symbol-uri-object))
          (setq symbol-trait (car (nth 5 (nth 1 symbol-uri-object)))))
        (when (nth 7 (nth 1 symbol-uri-object))
          (setq symbol-interface (car (nth 7 (nth 1 symbol-uri-object)))))
        (when (nth 9 (nth 1 symbol-uri-object))
          (setq symbol-function (car (nth 9 (nth 1 symbol-uri-object)))))
        (when (nth 11 (nth 1 symbol-uri-object))
          (setq symbol-is-superglobal t))

        ;; (message "\nsymbol-name: %S" symbol-name)
        ;; (message "symbol-scope: %S" symbol-scope)
        ;; (message "symbol-namespace: %S" symbol-namespace)
        ;; (message "symbol-class: %S" symbol-class)
        ;; (message "symbol-trait: %S" symbol-trait)
        ;; (message "symbol-interface: %S" symbol-interface)
        ;; (message "symbol-function: %S" symbol-function)

        ;; Place symbol in imenu if not there already
        ;; and is not superglobal
        ;; and is not $this
        (unless (or
                 symbol-is-this
                 symbol-is-superglobal)
          (cond

           ;; Symbol is inside namespace
           (symbol-namespace
            (let ((imenu-nail (format "namespace %s" symbol-namespace)))
              (cond

               ;; Symbol is inside class inside a namespace
               (symbol-class
                (let ((imenu-nail2 (format "class %s" symbol-class)))
                  (cond

                   ;; Symbol is inside function inside class inside namespace
                   (symbol-function
                    (let ((imenu-nail3 (format "function %s" symbol-function)))
                      (unless
                          (gethash
                           symbol-name
                           (gethash
                            imenu-nail3
                            (gethash
                             imenu-nail2
                             (gethash
                              imenu-nail
                              phps-mode-parser-sdt-symbol-imenu--table))))
                        (puthash
                         symbol-name
                         symbol-start
                         (gethash
                          imenu-nail3
                          (gethash
                           imenu-nail2
                           (gethash
                            imenu-nail
                            phps-mode-parser-sdt-symbol-imenu--table)))))))

                   ;; Symbol is inside class inside namespace
                   (t
                    (unless
                        (gethash
                         symbol-name
                         (gethash
                          imenu-nail2
                          (gethash
                           imenu-nail
                           phps-mode-parser-sdt-symbol-imenu--table)))
                      (puthash
                       symbol-name
                       symbol-start
                       (gethash
                        imenu-nail2
                        (gethash
                         imenu-nail
                         phps-mode-parser-sdt-symbol-imenu--table))))))))

               ;; Symbol is inside interface inside namespace
               (symbol-interface
                (let ((imenu-nail2 (format "interface %s" symbol-interface)))
                  (cond

                   ;; Symbol is inside function inside interface inside namespace
                   (symbol-function
                    (let ((imenu-nail3 (format "function %s" symbol-function)))
                      (unless
                          (gethash
                           symbol-name
                           (gethash
                            imenu-nail3
                            (gethash
                             imenu-nail2
                             (gethash
                              imenu-nail
                              phps-mode-parser-sdt-symbol-imenu--table))))
                        (puthash
                         symbol-name
                         symbol-start
                         (gethash
                          imenu-nail3
                          (gethash
                           imenu-nail2
                           (gethash
                            imenu-nail
                            phps-mode-parser-sdt-symbol-imenu--table)))))))

                   ;; Symbol is inside interface inside namespace
                   (t
                    (unless
                        (gethash
                         symbol-name
                         (gethash
                          imenu-nail2
                          (gethash
                           imenu-nail
                           phps-mode-parser-sdt-symbol-imenu--table)))
                      (puthash
                       symbol-name
                       symbol-start
                       (gethash
                        imenu-nail2
                        (gethash
                         imenu-nail
                         phps-mode-parser-sdt-symbol-imenu--table))))))))

               ;; Symbol is inside trait inside namespace
               (symbol-trait
                (let ((imenu-nail2 (format "trait %s" symbol-trait)))
                  (cond

                   ;; Symbol is inside function inside trait inside a namespace
                   (symbol-function
                    (let ((imenu-nail3 (format "function %s" symbol-function)))
                      (unless
                          (gethash
                           symbol-name
                           (gethash
                            imenu-nail3
                            (gethash
                             imenu-nail2
                             (gethash
                              imenu-nail
                              phps-mode-parser-sdt-symbol-imenu--table))))
                        (puthash
                         symbol-name
                         symbol-start
                         (gethash
                          imenu-nail3
                          (gethash
                           imenu-nail2
                           (gethash
                            imenu-nail
                            phps-mode-parser-sdt-symbol-imenu--table)))))))

                   ;; Symbol is inside trait inside namespace
                   (t
                    (unless
                        (gethash
                         symbol-name
                         (gethash
                          imenu-nail2
                          (gethash
                           imenu-nail
                           phps-mode-parser-sdt-symbol-imenu--table)))
                      (puthash
                       symbol-name
                       symbol-start
                       (gethash
                        imenu-nail2
                        (gethash
                         imenu-nail
                         phps-mode-parser-sdt-symbol-imenu--table))))))))

               ;; Symbol is inside a namespace
               (t
                (cond

                 ;; Symbol is inside function inside namespace
                 (symbol-function
                  (let ((imenu-nail2 (format "function %s" symbol-function)))
                    (unless
                        (gethash
                         symbol-name
                         (gethash
                          imenu-nail2
                          (gethash
                           imenu-nail
                           phps-mode-parser-sdt-symbol-imenu--table)))
                      (puthash
                       symbol-name
                       symbol-start
                       (gethash
                        imenu-nail2
                        (gethash
                         imenu-nail
                         phps-mode-parser-sdt-symbol-imenu--table))))))

                 ;; Symbol is inside a namespace
                 (t
                  (unless
                      (gethash
                       symbol-name
                       (gethash
                        imenu-nail
                        phps-mode-parser-sdt-symbol-imenu--table))
                    (puthash
                     symbol-name
                     symbol-start
                     (gethash
                      imenu-nail
                      phps-mode-parser-sdt-symbol-imenu--table)))))))))

           ;; Symbol is inside class
           (symbol-class
            (let ((imenu-nail (format "class %s" symbol-class)))
              (cond

               ;; Symbol is inside function inside class
               (symbol-function
                (let ((imenu-nail2 (format "function %s" symbol-function)))
                  (unless
                      (gethash
                       symbol-name
                       (gethash
                        imenu-nail2
                        (gethash
                         imenu-nail
                         phps-mode-parser-sdt-symbol-imenu--table)))
                    (puthash
                     symbol-name
                     symbol-start
                     (gethash
                      imenu-nail2
                      (gethash
                       imenu-nail
                       phps-mode-parser-sdt-symbol-imenu--table))))))

               ;; Symbol is inside class
               (t
                (unless
                    (gethash
                     symbol-name
                     (gethash
                      imenu-nail
                      phps-mode-parser-sdt-symbol-imenu--table))
                  (puthash
                   symbol-name
                   symbol-start
                   (gethash
                    imenu-nail
                    phps-mode-parser-sdt-symbol-imenu--table)))))))

           ;; Symbol is inside trait
           (symbol-trait
            (let ((imenu-nail (format "trait %s" symbol-trait)))
              (cond

               ;; Symbol is inside function inside trait
               (symbol-function
                (let ((imenu-nail2 (format "function %s" symbol-function)))
                  (unless
                      (gethash
                       symbol-name
                       (gethash
                        imenu-nail2
                        (gethash
                         imenu-nail
                         phps-mode-parser-sdt-symbol-imenu--table)))
                    (puthash
                     symbol-name
                     symbol-start
                     (gethash
                      imenu-nail2
                      (gethash
                       imenu-nail
                       phps-mode-parser-sdt-symbol-imenu--table))))))

               ;; Symbol is inside trait
               (t
                (unless
                    (gethash
                     symbol-name
                     (gethash
                      imenu-nail
                      phps-mode-parser-sdt-symbol-imenu--table))
                  (puthash
                   symbol-name
                   symbol-start
                   (gethash
                    imenu-nail
                    phps-mode-parser-sdt-symbol-imenu--table)))))))

           ;; Symbol is inside interface
           (symbol-interface
            (let ((imenu-nail (format "interface %s" symbol-interface)))
              (cond

               ;; Symbol is inside function inside interface
               (symbol-function
                (let ((imenu-nail2 (format "function %s" symbol-function)))
                  (unless
                      (gethash
                       symbol-name
                       (gethash
                        imenu-nail2
                        (gethash
                         imenu-nail
                         phps-mode-parser-sdt-symbol-imenu--table)))
                    (puthash
                     symbol-name
                     symbol-start
                     (gethash
                      imenu-nail2
                      (gethash
                       imenu-nail
                       phps-mode-parser-sdt-symbol-imenu--table))))))

               ;; Symbol is inside interface
               (t
                (unless
                    (gethash
                     symbol-name
                     (gethash
                      imenu-nail
                      phps-mode-parser-sdt-symbol-imenu--table))
                  (puthash
                   symbol-name
                   symbol-start
                   (gethash
                    imenu-nail
                    phps-mode-parser-sdt-symbol-imenu--table)))))))

           (symbol-function
            (let ((imenu-nail (format "function %s" symbol-function)))
              (unless
                  (gethash
                   symbol-name
                   (gethash
                    imenu-nail
                    phps-mode-parser-sdt-symbol-imenu--table))
                (puthash
                 symbol-name
                 symbol-start
                 (gethash
                  imenu-nail
                  phps-mode-parser-sdt-symbol-imenu--table)))))

           ;; Symbol is in no scope
           (t
            (unless (gethash symbol-name phps-mode-parser-sdt-symbol-imenu--table)
              (puthash
               symbol-name
               symbol-start
               phps-mode-parser-sdt-symbol-imenu--table)))))


        ;; (message
        ;;  "assign symbol uri: %S from %S + %S, start: %S, end: %S, object: %S"
        ;;  symbol-uri
        ;;  symbol-name
        ;;  symbol-scope
        ;;  symbol-start
        ;;  symbol-end
        ;;  symbol-uri-object)

        (setq
         phps-mode-parser-sdt-symbol-table-index
         (1+ phps-mode-parser-sdt-symbol-table-index))

        ;; Register new symbol in symbol-table
        ;; and place a reference to it in the symbol URI hash-map
        (if (gethash symbol-uri phps-mode-parser-sdt-symbol-table-by-uri)
            (progn
              (puthash
               phps-mode-parser-sdt-symbol-table-index
               (list
                symbol-uri
                symbol-start
                symbol-end)
               phps-mode-parser-sdt-symbol-table)
              (puthash
               symbol-uri
               (append
                (gethash symbol-uri phps-mode-parser-sdt-symbol-table-by-uri)
                (list phps-mode-parser-sdt-symbol-table-index))
               phps-mode-parser-sdt-symbol-table-by-uri))

          (puthash
           phps-mode-parser-sdt-symbol-table-index
           (list
            symbol-uri
            symbol-start
            symbol-end)
           phps-mode-parser-sdt-symbol-table)
          (puthash
           symbol-uri
           (list phps-mode-parser-sdt-symbol-table-index)
           phps-mode-parser-sdt-symbol-table-by-uri))))
    (setq
     phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack
     nil))

  (when phps-mode-parser-sdt--bookkeeping-symbol-stack
    ;; Bookkeeping hit / misses of symbol references here
    (dolist (
             symbol-list
             phps-mode-parser-sdt--bookkeeping-symbol-stack)
      (let* ((symbol-name (nth 0 symbol-list))
             (symbol-scope (nth 1 symbol-list))
             (symbol-start (nth 2 symbol-list))
             (symbol-end (nth 3 symbol-list))
             (symbol-uri-object
              (phps-mode-parser-sdt--get-symbol-uri
               symbol-name
               symbol-scope))
             (symbol-uri (car symbol-uri-object))
             (symbol-object-operator
              (nth 13 (nth 1 symbol-uri-object)))
             (symbol-static-member
              (nth 15 (nth 1 symbol-uri-object)))
             (symbol-hit 0))

        (unless (or
                 (and
                  symbol-object-operator
                  (not (string= (downcase symbol-object-operator) "$this")))
                 (and
                  symbol-static-member
                  (not
                   (or
                    (and
                     (listp symbol-static-member)
                     (string= (downcase (plist-get symbol-static-member 'name)) "self"))
                    (and
                     (listp symbol-static-member)
                     (string= (downcase (plist-get symbol-static-member 'name)) "static"))))))
          (cond

           ;; Super-global variable
           ((gethash
             symbol-name
             phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
            (setq symbol-hit -1))

           ;; Declared variable
           ((gethash
             symbol-uri
             phps-mode-parser-sdt-symbol-table-by-uri)
            ;; (message "matches: %S" (gethash
            ;;  symbol-uri
            ;;  phps-mode-parser-sdt-symbol-table-by-uri))
            (let* ((matching-symbol-ids
                    (gethash
                     symbol-uri
                     phps-mode-parser-sdt-symbol-table-by-uri))
                   (matching-symbol-index 0)
                   (matching-symbol-count (length matching-symbol-ids))
                   (matching-hit))
              (while (and
                      (not matching-hit)
                      (< matching-symbol-index matching-symbol-count))
                (let* ((matching-symbol-id
                        (nth matching-symbol-index matching-symbol-ids))
                       (matching-symbol
                        (gethash
                         matching-symbol-id
                         phps-mode-parser-sdt-symbol-table))
                       (matching-symbol-start
                        (nth 1 matching-symbol)))
                  ;; (message "matching-symbol: %S" matching-symbol)
                  ;; (message "matching-symbol-start: %S" matching-symbol-start)
                  (when (<= matching-symbol-start symbol-start)
                    (setq matching-hit t)
                    (setq symbol-hit matching-symbol-id)))
                (setq matching-symbol-index (1+ matching-symbol-index))))))

          (puthash
           (list
            symbol-start
            symbol-end)
           symbol-hit
           phps-mode-parser-sdt-bookkeeping))

        ;; (message
        ;;  "reference symbol uri: %S from %S + %S, start: %S, end: %S, object: %S, hit?: %S"
        ;;  symbol-uri
        ;;  symbol-name
        ;;  symbol-scope
        ;;  symbol-start
        ;;  symbol-end
        ;;  symbol-uri-object
        ;;  symbol-hit)

        ))
    (setq
     phps-mode-parser-sdt--bookkeeping-symbol-stack
     nil)))


;; SDT starts here


;; 0 ((start) (top_statement_list))
(puthash 0 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 1 ((reserved_non_modifiers) (T_INCLUDE))
(puthash 1 (lambda(_args _terminals) 'T_INCLUDE) phps-mode-parser--table-translations)

;; 2 ((reserved_non_modifiers) (T_INCLUDE_ONCE))
(puthash 2 (lambda(_args _terminals) 'T_INCLUDE_ONCE) phps-mode-parser--table-translations)

;; 3 ((reserved_non_modifiers) (T_EVAL))
(puthash 3 (lambda(_args _terminals) 'T_EVAL) phps-mode-parser--table-translations)

;; 4 ((reserved_non_modifiers) (T_REQUIRE))
(puthash 4 (lambda(_args _terminals) 'T_REQUIRE) phps-mode-parser--table-translations)

;; 5 ((reserved_non_modifiers) (T_REQUIRE_ONCE))
(puthash 5 (lambda(_args _terminals) 'T_REQUIRE_ONCE) phps-mode-parser--table-translations)

;; 6 ((reserved_non_modifiers) (T_LOGICAL_OR))
(puthash 6 (lambda(_args _terminals) 'T_LOGICAL_OR) phps-mode-parser--table-translations)

;; 7 ((reserved_non_modifiers) (T_LOGICAL_XOR))
(puthash 7 (lambda(_args _terminals) 'T_LOGICAL_XOR) phps-mode-parser--table-translations)

;; 8 ((reserved_non_modifiers) (T_LOGICAL_AND))
(puthash 8 (lambda(_args _terminals) 'T_LOGICAL_AND) phps-mode-parser--table-translations)

;; 9 ((reserved_non_modifiers) (T_INSTANCEOF))
(puthash 9 (lambda(_args _terminals) 'T_INSTANCEOF) phps-mode-parser--table-translations)

;; 10 ((reserved_non_modifiers) (T_NEW))
(puthash 10 (lambda(_args _terminals) 'T_NEW) phps-mode-parser--table-translations)

;; 11 ((reserved_non_modifiers) (T_CLONE))
(puthash 11 (lambda(_args _terminals) 'T_CLONE) phps-mode-parser--table-translations)

;; 12 ((reserved_non_modifiers) (T_EXIT))
(puthash 12 (lambda(_args _terminals) 'T_EXIT) phps-mode-parser--table-translations)

;; 13 ((reserved_non_modifiers) (T_IF))
(puthash 13 (lambda(_args _terminals) 'T_IF) phps-mode-parser--table-translations)

;; 14 ((reserved_non_modifiers) (T_ELSEIF))
(puthash 14 (lambda(_args _terminals) 'T_ELSEIF) phps-mode-parser--table-translations)

;; 15 ((reserved_non_modifiers) (T_ELSE))
(puthash 15 (lambda(_args _terminals) 'T_ELSE) phps-mode-parser--table-translations)

;; 16 ((reserved_non_modifiers) (T_ENDIF))
(puthash 16 (lambda(_args _terminals) 'T_ENDIF) phps-mode-parser--table-translations)

;; 17 ((reserved_non_modifiers) (T_ECHO))
(puthash 17 (lambda(_args _terminals) 'T_ECHO) phps-mode-parser--table-translations)

;; 18 ((reserved_non_modifiers) (T_DO))
(puthash 18 (lambda(_args _terminals) 'T_DO) phps-mode-parser--table-translations)

;; 19 ((reserved_non_modifiers) (T_WHILE))
(puthash 19 (lambda(_args _terminals) 'T_WHILE) phps-mode-parser--table-translations)

;; 20 ((reserved_non_modifiers) (T_ENDWHILE))
(puthash 20 (lambda(_args _terminals) 'T_ENDWHILE) phps-mode-parser--table-translations)

;; 21 ((reserved_non_modifiers) (T_FOR))
(puthash 21 (lambda(_args _terminals) 'T_FOR) phps-mode-parser--table-translations)

;; 22 ((reserved_non_modifiers) (T_ENDFOR))
(puthash 22 (lambda(_args _terminals) 'T_ENDFOR) phps-mode-parser--table-translations)

;; 23 ((reserved_non_modifiers) (T_FOREACH))
(puthash 23 (lambda(_args _terminals) 'T_FOREACH) phps-mode-parser--table-translations)

;; 24 ((reserved_non_modifiers) (T_ENDFOREACH))
(puthash 24 (lambda(_args _terminals) 'T_ENDFOREACH) phps-mode-parser--table-translations)

;; 25 ((reserved_non_modifiers) (T_DECLARE))
(puthash 25 (lambda(_args _terminals) 'T_DECLARE) phps-mode-parser--table-translations)

;; 26 ((reserved_non_modifiers) (T_ENDDECLARE))
(puthash 26 (lambda(_args _terminals) 'T_ENDDECLARE) phps-mode-parser--table-translations)

;; 27 ((reserved_non_modifiers) (T_AS))
(puthash 27 (lambda(_args _terminals) 'T_AS) phps-mode-parser--table-translations)

;; 28 ((reserved_non_modifiers) (T_TRY))
(puthash 28 (lambda(_args _terminals) 'T_TRY) phps-mode-parser--table-translations)

;; 29 ((reserved_non_modifiers) (T_CATCH))
(puthash 29 (lambda(_args _terminals) 'T_CATCH) phps-mode-parser--table-translations)

;; 30 ((reserved_non_modifiers) (T_FINALLY))
(puthash 30 (lambda(_args _terminals) 'T_FINALLY) phps-mode-parser--table-translations)

;; 31 ((reserved_non_modifiers) (T_THROW))
(puthash 31 (lambda(_args _terminals) 'T_THROW) phps-mode-parser--table-translations)

;; 32 ((reserved_non_modifiers) (T_USE))
(puthash 32 (lambda(_args _terminals) 'T_USE) phps-mode-parser--table-translations)

;; 33 ((reserved_non_modifiers) (T_INSTEADOF))
(puthash 33 (lambda(_args _terminals) 'T_INSTEADOF) phps-mode-parser--table-translations)

;; 34 ((reserved_non_modifiers) (T_GLOBAL))
(puthash 34 (lambda(_args _terminals) 'T_GLOBAL) phps-mode-parser--table-translations)

;; 35 ((reserved_non_modifiers) (T_VAR))
(puthash 35 (lambda(_args _terminals) 'T_VAR) phps-mode-parser--table-translations)

;; 36 ((reserved_non_modifiers) (T_UNSET))
(puthash 36 (lambda(_args _terminals) 'T_UNSET) phps-mode-parser--table-translations)

;; 37 ((reserved_non_modifiers) (T_ISSET))
(puthash 37 (lambda(_args _terminals) 'T_ISSET) phps-mode-parser--table-translations)

;; 38 ((reserved_non_modifiers) (T_EMPTY))
(puthash 38 (lambda(_args _terminals) 'T_EMPTY) phps-mode-parser--table-translations)

;; 39 ((reserved_non_modifiers) (T_CONTINUE))
(puthash 39 (lambda(_args _terminals) 'T_CONTINUE) phps-mode-parser--table-translations)

;; 40 ((reserved_non_modifiers) (T_GOTO))
(puthash 40 (lambda(_args _terminals) 'T_GOTO) phps-mode-parser--table-translations)

;; 41 ((reserved_non_modifiers) (T_FUNCTION))
(puthash 41 (lambda(_args _terminals) 'T_FUNCTION) phps-mode-parser--table-translations)

;; 42 ((reserved_non_modifiers) (T_CONST))
(puthash 42 (lambda(_args _terminals) 'T_CONST) phps-mode-parser--table-translations)

;; 43 ((reserved_non_modifiers) (T_RETURN))
(puthash 43 (lambda(_args _terminals) 'T_RETURN) phps-mode-parser--table-translations)

;; 44 ((reserved_non_modifiers) (T_PRINT))
(puthash 44 (lambda(_args _terminals) 'T_PRINT) phps-mode-parser--table-translations)

;; 45 ((reserved_non_modifiers) (T_YIELD))
(puthash 45 (lambda(_args _terminals) 'T_YIELD) phps-mode-parser--table-translations)

;; 46 ((reserved_non_modifiers) (T_LIST))
(puthash 46 (lambda(_args _terminals) 'T_LIST) phps-mode-parser--table-translations)

;; 47 ((reserved_non_modifiers) (T_SWITCH))
(puthash 47 (lambda(_args _terminals) 'T_SWITCH) phps-mode-parser--table-translations)

;; 48 ((reserved_non_modifiers) (T_ENDSWITCH))
(puthash 48 (lambda(_args _terminals) 'T_ENDSWITCH) phps-mode-parser--table-translations)

;; 49 ((reserved_non_modifiers) (T_CASE))
(puthash 49 (lambda(_args _terminals) 'T_CASE) phps-mode-parser--table-translations)

;; 50 ((reserved_non_modifiers) (T_DEFAULT))
(puthash 50 (lambda(_args _terminals) 'T_DEFAULT) phps-mode-parser--table-translations)

;; 51 ((reserved_non_modifiers) (T_BREAK))
(puthash 51 (lambda(_args _terminals) 'T_BREAK) phps-mode-parser--table-translations)

;; 52 ((reserved_non_modifiers) (T_ARRAY))
(puthash 52 (lambda(_args _terminals) 'T_ARRAY) phps-mode-parser--table-translations)

;; 53 ((reserved_non_modifiers) (T_CALLABLE))
(puthash 53 (lambda(_args _terminals) 'T_CALLABLE) phps-mode-parser--table-translations)

;; 54 ((reserved_non_modifiers) (T_EXTENDS))
(puthash 54 (lambda(_args _terminals) 'T_EXTENDS) phps-mode-parser--table-translations)

;; 55 ((reserved_non_modifiers) (T_IMPLEMENTS))
(puthash 55 (lambda(_args _terminals) 'T_IMPLEMENTS) phps-mode-parser--table-translations)

;; 56 ((reserved_non_modifiers) (T_NAMESPACE))
(puthash 56 (lambda(_args _terminals) 'T_NAMESPACE) phps-mode-parser--table-translations)

;; 57 ((reserved_non_modifiers) (T_TRAIT))
(puthash 57 (lambda(_args _terminals) 'T_TRAIT) phps-mode-parser--table-translations)

;; 58 ((reserved_non_modifiers) (T_INTERFACE))
(puthash 58 (lambda(_args _terminals) 'T_INTERFACE) phps-mode-parser--table-translations)

;; 59 ((reserved_non_modifiers) (T_CLASS))
(puthash 59 (lambda(_args _terminals) 'T_CLASS) phps-mode-parser--table-translations)

;; 60 ((reserved_non_modifiers) (T_CLASS_C))
(puthash 60 (lambda(_args _terminals) 'T_CLASS_C) phps-mode-parser--table-translations)

;; 61 ((reserved_non_modifiers) (T_TRAIT_C))
(puthash 61 (lambda(_args _terminals) 'T_TRAIT_C) phps-mode-parser--table-translations)

;; 62 ((reserved_non_modifiers) (T_FUNC_C))
(puthash 62 (lambda(_args _terminals) 'T_FUNC_C) phps-mode-parser--table-translations)

;; 63 ((reserved_non_modifiers) (T_METHOD_C))
(puthash 63 (lambda(_args _terminals) 'T_METHOD_C) phps-mode-parser--table-translations)

;; 64 ((reserved_non_modifiers) (T_LINE))
(puthash 64 (lambda(_args _terminals) 'T_LINE) phps-mode-parser--table-translations)

;; 65 ((reserved_non_modifiers) (T_FILE))
(puthash 65 (lambda(_args _terminals) 'T_FILE) phps-mode-parser--table-translations)

;; 66 ((reserved_non_modifiers) (T_DIR))
(puthash 66 (lambda(_args _terminals) 'T_DIR) phps-mode-parser--table-translations)

;; 67 ((reserved_non_modifiers) (T_NS_C))
(puthash 67 (lambda(_args _terminals) 'T_NS_C) phps-mode-parser--table-translations)

;; 68 ((reserved_non_modifiers) (T_FN))
(puthash 68 (lambda(_args _terminals) 'T_FN) phps-mode-parser--table-translations)

;; 69 ((reserved_non_modifiers) (T_MATCH))
(puthash 69 (lambda(_args _terminals) 'T_MATCH) phps-mode-parser--table-translations)

;; 70 ((reserved_non_modifiers) (T_ENUM))
(puthash 70 (lambda(_args _terminals) 'T_ENUM) phps-mode-parser--table-translations)

;; 71 ((reserved_non_modifiers) (T_PROPERTY_C))
(puthash 71 (lambda(_args _terminals) 'T_PROPERTY_C) phps-mode-parser--table-translations)

;; 72 ((semi_reserved) (reserved_non_modifiers))
(puthash 72 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 73 ((semi_reserved) (T_STATIC))
(puthash 73 (lambda(_args _terminals) 'T_STATIC) phps-mode-parser--table-translations)

;; 74 ((semi_reserved) (T_ABSTRACT))
(puthash 74 (lambda(_args _terminals) 'T_ABSTRACT) phps-mode-parser--table-translations)

;; 75 ((semi_reserved) (T_FINAL))
(puthash 75 (lambda(_args _terminals) 'T_FINAL) phps-mode-parser--table-translations)

;; 76 ((semi_reserved) (T_PRIVATE))
(puthash 76 (lambda(_args _terminals) 'T_PRIVATE) phps-mode-parser--table-translations)

;; 77 ((semi_reserved) (T_PROTECTED))
(puthash 77 (lambda(_args _terminals) 'T_PROTECTED) phps-mode-parser--table-translations)

;; 78 ((semi_reserved) (T_PUBLIC))
(puthash 78 (lambda(_args _terminals) 'T_PUBLIC) phps-mode-parser--table-translations)

;; 79 ((semi_reserved) (T_READONLY))
(puthash 79 (lambda(_args _terminals) 'T_READONLY) phps-mode-parser--table-translations)

;; 80 ((ampersand) (T_AMPERSAND_FOLLOWED_BY_VAR_OR_VARARG))
(puthash 80 (lambda(_args _terminals) 'T_AMPERSAND_FOLLOWED_BY_VAR_OR_VARARG) phps-mode-parser--table-translations)

;; 81 ((ampersand) (T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG))
(puthash 81 (lambda(_args _terminals) 'T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG) phps-mode-parser--table-translations)

;; 82 ((identifier) (T_STRING))
(puthash 82 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 83 ((identifier) (semi_reserved))
(puthash 83 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 84 ((top_statement_list) (top_statement_list top_statement))
(puthash
 84
 (lambda(args _terminals)
   (if (car args) (append (car args) (cdr args)) (cdr args)))
 phps-mode-parser--table-translations)

;; 85 ((top_statement_list) (%empty))
(puthash 85 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 86 ((namespace_declaration_name) (identifier))
(puthash
 86
 (lambda(args terminals)
   (let ((name args)
         (index (car (cdr terminals))))

     ;; Add to imenu if not there already
     (let ((imenu-nail (format "namespace %s" name)))
       (unless (gethash
                imenu-nail
                phps-mode-parser-sdt-symbol-imenu--table)
         (let ((namespace-table (make-hash-table :test 'equal)))
           (puthash
            'declaration
            index
            namespace-table)
           (puthash
            imenu-nail
            namespace-table
            phps-mode-parser-sdt-symbol-imenu--table))))

     (push
      (list 'namespace name index)
      phps-mode-parser-sdt--bookkeeping-namespace)
     (setq
      phps-mode-parser-sdt-symbol-imenu--namespace
      (list name (car (cdr terminals))))

     args))
 phps-mode-parser--table-translations)

;; 87 ((namespace_declaration_name) (T_NAME_QUALIFIED))
(puthash
 87
 (lambda(args terminals)
   (let ((name args)
         (index (car (cdr terminals))))

     ;; Add to imenu if not there already
     (let ((imenu-nail (format "namespace %s" name)))
       (unless (gethash
                imenu-nail
                phps-mode-parser-sdt-symbol-imenu--table)
         (let ((namespace-table (make-hash-table :test 'equal)))
           (puthash
            'declaration
            index
            namespace-table)
           (puthash
            imenu-nail
            namespace-table
            phps-mode-parser-sdt-symbol-imenu--table))))

     (push
      (list 'namespace name index)
      phps-mode-parser-sdt--bookkeeping-namespace)
     (setq
      phps-mode-parser-sdt-symbol-imenu--namespace
      (list name (car (cdr terminals))))

     args))
 phps-mode-parser--table-translations)

;; 88 ((namespace_name) (T_STRING))
(puthash 88 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 89 ((namespace_name) (T_NAME_QUALIFIED))
(puthash 89 (lambda(_args terminals) terminals) phps-mode-parser--table-translations)

;; 90 ((legacy_namespace_name) (namespace_name))
(puthash 90 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 91 ((legacy_namespace_name) (T_NAME_FULLY_QUALIFIED))
(puthash 91 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 92 ((name) (T_STRING))
(puthash
 92
 (lambda(args _terminals)
   `(
     ast-type
     string-name
     name
     ,args
     )
   )
 phps-mode-parser--table-translations)

;; 93 ((name) (T_NAME_QUALIFIED))
(puthash
 93
 (lambda(args _terminals)
   `(
     ast-type
     qualified-name
     name
     ,args
     )
   )
 phps-mode-parser--table-translations)

;; 94 ((name) (T_NAME_FULLY_QUALIFIED))
(puthash
 94
 (lambda(args _terminals)
   `(
     ast-type
     fully-qualified-name
     name
     ,args
     )
   )
 phps-mode-parser--table-translations)

;; 95 ((name) (T_NAME_RELATIVE))
(puthash
 95
 (lambda(args _terminals)
   `(
     ast-type
     relative-name
     name
     ,args
     )
   )
 phps-mode-parser--table-translations)

;; 96 ((attribute_decl) (class_name))
(puthash
 96
 (lambda(args _terminals)
   `(
     ast-type
     attribute-decl
     class-name
     ,args
     ))
 phps-mode-parser--table-translations)

;; 97 ((attribute_decl) (class_name argument_list))
(puthash
 97
 (lambda(args _terminals)
   `(
     ast-type
     attribute-decl
     class-name
     ,(nth 0 args)
     argument-list
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 98 ((attribute_group) (attribute_decl))
(puthash
 98
 (lambda(args _terminals)
   `(
     ast-type
     attribute-group
     attribute-decl
     (,args)
     ))
 phps-mode-parser--table-translations)

;; 99 ((attribute_group) (attribute_group "," attribute_decl))
(puthash
 99
 (lambda(args _terminals)
   `(
     ast-type
     attribute-group
     attribute-group
     ,(append (plist-get (nth 0 args) 'ast-type) (list (nth 2 args)))
     ))
 phps-mode-parser--table-translations)

;; 100 ((attribute) (T_ATTRIBUTE attribute_group possible_comma "]"))
(puthash
 100
 (lambda(args _terminals)
   `(
     ast-type
     attribute
     attribute-group
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 101 ((attributes) (attribute))
(puthash
 101
 (lambda(args _terminals)
   `(
     ast-type
     attributes
     attributes
     (,args)
     ))
 phps-mode-parser--table-translations)

;; 102 ((attributes) (attributes attribute))
(puthash 102 (lambda(args _terminals) (append (nth 0 args) (list (nth 1 args)))) phps-mode-parser--table-translations)

;; 103 ((attributed_statement) (function_declaration_statement))
(puthash 103 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 104 ((attributed_statement) (class_declaration_statement))
(puthash 104 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 105 ((attributed_statement) (trait_declaration_statement))
(puthash 105 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 106 ((attributed_statement) (interface_declaration_statement))
(puthash 106 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 107 ((attributed_statement) (enum_declaration_statement))
(puthash 107 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 108 ((attributed_top_statement) (attributed_statement))
(puthash 108 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 109  ((attributed_top_statement) (T_CONST const_list ";"))
(puthash
 109
 (lambda(args _terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   `(
     ast-type
     const-list-atttop-statement
     ast-value
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 110 ((top_statement) (statement))
(puthash
 110
 (lambda(args _terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   args)
 phps-mode-parser--table-translations)

;; 111 ((top_statement) (attributed_statement))
(puthash
 111
 (lambda(args _terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   args)
 phps-mode-parser--table-translations)

;; 112 ((top_statement) (attributes attributed_statement))
(puthash
 112
 (lambda(args _terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   args)
 phps-mode-parser--table-translations)

;; 113 ((top_statement) (T_HALT_COMPILER "(" ")" ";"))
(puthash
 113
 (lambda(args _terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   (nth 0 args))
 phps-mode-parser--table-translations)

;; 114 top_statement -> (T_NAMESPACE namespace_declaration_name ";")
(puthash
 114
 (lambda(args terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   `(
     ast-type
     namespace
     ast-name
     ,(nth 1 args)
     ast-index
     ,(car (cdr (nth 1 terminals)))
     ast-start
     ,(car (cdr (nth 1 terminals)))
     ast-end
     ,(cdr (cdr (nth 1 terminals)))))
 phps-mode-parser--table-translations)

;; 115 top_statement -> (T_NAMESPACE namespace_declaration_name "{" top_statement_list "}")
(puthash
 115
 (lambda(args terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   (setq
    phps-mode-parser-sdt-symbol-imenu--namespace
    nil)
   (setq
    phps-mode-parser-sdt--bookkeeping-namespace
    nil)
   `(
     ast-type
     namespace
     ast-name
     ,(nth 1 args)
     ast-index
     ,(car (cdr (nth 1 terminals)))
     ast-start
     ,(car (cdr (nth 2 terminals)))
     ast-end
     ,(cdr (cdr (nth 2 terminals)))
     top-statement-list
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 116 top_statement -> (T_NAMESPACE "{" top_statement_list "}")
(puthash
 116
 (lambda(args terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   `(
     ast-type
     namespace
     ast-index
     ,(car (cdr (nth 0 terminals)))
     ast-start
     ,(car (cdr (nth 1 terminals)))
     ast-end
     ,(car (cdr (nth 3 terminals)))
     top-statement-list
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 117 ((top_statement) (T_USE mixed_group_use_declaration ";"))
(puthash
 117
 (lambda(args _terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   `(
     ast-type
     mixed-group-use-declaration-top-statement
     ast-value
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 118 ((top_statement) (T_USE use_type group_use_declaration ";"))
(puthash
 118
 (lambda(args _terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   `(
     ast-type
     type-group-use-declaration-top-statement
     use-type
     ,(nth 1 args)
     group-use-declaration
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 119 ((top_statement) (T_USE use_declarations ";"))
(puthash
 119
 (lambda(args _terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   `(
     ast-type
     use-declarations-top-statement
     ast-value
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 120 ((top_statement) (T_USE use_type use_declarations ";"))
(puthash
 120
 (lambda(args _terminals)
   (phps-mode-parser-sdt--parse-top-statement)
   `(
     ast-type
     type-use-declarations-top-statement
     ast-value
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 121 ((use_type) (T_FUNCTION))
(puthash 121 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 122 ((use_type) (T_CONST))
(puthash 122 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 123 ((group_use_declaration) (legacy_namespace_name T_NS_SEPARATOR "{" unprefixed_use_declarations possible_comma "}"))
(puthash
 123
 (lambda(args _terminals)
   `(
     ast-type
     legacy-group-use-declaration
     unprefixed-use-declarations
     ,(nth 3 args)
     ))
 phps-mode-parser--table-translations)

;; 124 ((mixed_group_use_declaration) (legacy_namespace_name T_NS_SEPARATOR "{" inline_use_declarations possible_comma "}"))
(puthash
 124
 (lambda(args _terminals)
   `(
     ast-type
     mixed-group-use-declaration
     inline-use-declarations
     ,(nth 3 args)
     ))
 phps-mode-parser--table-translations)

;; 125 ((possible_comma) (%empty))
(puthash 125 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 126 ((possible_comma) (","))
(puthash 126 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 127 ((inline_use_declarations) (inline_use_declarations "," inline_use_declaration))
(puthash
 127
 (lambda(args _terminals)
   `(
     ast-type
     inline-use-declarations
     ,(append (nth 0 args) (list (nth 2 args)))
     ))
 phps-mode-parser--table-translations)

;; 128 ((inline_use_declarations) (inline_use_declaration))
(puthash
 128
 (lambda(args _terminals)
   `(
     ast-type
     inline-use-declarations
     ,(list (nth 1 args))
     ))
 phps-mode-parser--table-translations)

;; 129 ((unprefixed_use_declarations) (unprefixed_use_declarations "," unprefixed_use_declaration))
(puthash
 129
 (lambda(args _terminals)
   `(
     ast-type
     unprefixed-use-declarations
     ,(append (nth 0 args) (list (nth 2 args)))
     ))
 phps-mode-parser--table-translations)

;; 130 ((unprefixed_use_declarations) (unprefixed_use_declaration))
(puthash
 130
 (lambda(args _terminals)
   `(
     ast-type
     unprefixed-use-declarations
     ,(list args))
   )
 phps-mode-parser--table-translations)

;; 131 ((use_declarations) (use_declarations "," use_declaration))
(puthash
 131
 (lambda(args _terminals)
   `(
     ast-type
     use-declarations
     ,(append (nth 0 args) (list (nth 2 args)))
     ))
 phps-mode-parser--table-translations)

;; 132 ((use_declarations) (use_declaration))
(puthash
 132
 (lambda(args _terminals)
   `(
     ast-type
     use-declarations
     ,(list args)
     ))
 phps-mode-parser--table-translations)

;; 133 ((inline_use_declaration) (unprefixed_use_declaration))
(puthash
 133
 (lambda(args _terminals)
   `(
     ast-type
     inline-use-declaration
     declation
     ,(list args)
     ))
 phps-mode-parser--table-translations)

;; 134 ((inline_use_declaration) (use_type unprefixed_use_declaration))
(puthash
 134
 (lambda(args _terminals)
   `(
     ast-type
     inline-use-declaration
     use-type
     ,(nth 0 args)
     declaration
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 135 ((unprefixed_use_declaration) (namespace_name))
(puthash
 135
 (lambda(args _terminals)
   `(
     namespace-name
     ,args
     ))
 phps-mode-parser--table-translations)

;; 136 ((unprefixed_use_declaration) (namespace_name T_AS T_STRING))
(puthash
 136
 (lambda(args _terminals)
   `(
     namespace-name
     ,(nth 0 args)
     as
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 137 ((use_declaration) (legacy_namespace_name))
(puthash
 137
 (lambda(args _terminals)
   `(
     ast-type
     use-declaration
     legacy-namespace-name
     ,args
     ))
 phps-mode-parser--table-translations)

;; 138 ((use_declaration) (legacy_namespace_name T_AS T_STRING))
(puthash
 138
 (lambda(args _terminals)
   `(
     ast-type
     use-declaration
     legacy-namespace-name
     ,(nth 0 args)
     as
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 139 ((const_list) (const_list "," const_decl))
(puthash 139 (lambda(args _terminals) (append (nth 0 args) (list (nth 2 args)))) phps-mode-parser--table-translations)

;; 140 ((const_list) (const_decl))
(puthash 140 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 141 inner_statement_list -> (inner_statement_list inner_statement)
(puthash
 141
 (lambda(args _terminals)
   (if (car args)
       (append (car args) (cdr args))
     (cdr args)))
 phps-mode-parser--table-translations)

;; 142 ((inner_statement_list) (%empty))
(puthash 142 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 143 ((inner_statement) (statement))
(puthash 143 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 144 ((inner_statement) (attributed_statement))
(puthash 144 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 145 ((inner_statement) (attributes attributed_statement))
(puthash 145 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 146 ((inner_statement) (T_HALT_COMPILER "(" ")" ";"))
(puthash 146 (lambda(_args _terminals) '(ast-type halt-compiler-inner-statement)) phps-mode-parser--table-translations)

;; 147 ((statement) ("{" inner_statement_list "}"))
(puthash
 147
 (lambda(args _terminals)
   (nth 1 args))
 phps-mode-parser--table-translations)

;; 148 ((statement) (if_stmt))
(puthash
 148
 (lambda(args _terminals)
   args)
 phps-mode-parser--table-translations)

;; 149 ((statement) (alt_if_stmt))
(puthash
 149
 (lambda(args _terminals)
   args)
 phps-mode-parser--table-translations)

;; 150 ((statement) (T_WHILE "(" expr ")" while_statement))
(puthash
 150
 (lambda(args _terminals)
   `(
     ast-type
     while-statement
     expr
     ,(nth 2 args)
     while-statement
     ,(nth 4 args))
   )
 phps-mode-parser--table-translations)

;; 151 ((statement) (T_DO statement T_WHILE "(" expr ")" ";"))
(puthash
 151
 (lambda(args _terminals)
   `(
     ast-type
     do-statement
     statement
     ,(nth 1 args)
     expr
     ,(nth 4 args)
     ))
 phps-mode-parser--table-translations)

;; 152 ((statement) (T_FOR "(" for_exprs ";" for_exprs ";" for_exprs ")" for_statement))
(puthash
 152
 (lambda(args _terminals)
   `(
     ast-type
     for-statement
     initial
     ,(nth 2 args)
     test
     ,(nth 4 args)
     incremental
     ,(nth 6 args)
     for-statement
     ,(nth 8 args)
     ))
 phps-mode-parser--table-translations)

;; 153 ((statement) (T_SWITCH "(" expr ")" switch_case_list))
(puthash
 153
 (lambda(args _terminals)
   `(
     ast-type
     switch-statement
     expr
     ,(nth 2 args)
     switch-case-list
     ,(nth 4 args)
     ))
 phps-mode-parser--table-translations)

;; 154 ((statement) (T_BREAK optional_expr ";"))
(puthash
 154
 (lambda(args _terminals)
   `(
     ast-type
     break-statement
     optional-expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 155 ((statement) (T_CONTINUE optional_expr ";"))
(puthash
 155
 (lambda(args _terminals)
   `(
     ast-type
     continue-statement
     optional-expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 156 ((statement) (T_RETURN optional_expr ";"))
(puthash
 156
 (lambda(args _terminals)
   `(
     ast-type
     return-statement
     optional-expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 157 ((statement) (T_GLOBAL global_var_list ";"))
(puthash
 157
 (lambda(args _terminals)
   (dolist (stack-item phps-mode-parser-sdt--bookkeeping-symbol-stack)
     (push '(global) (nth 1 stack-item)))
   (let ((global-var-list (nth 1 args)))
     (dolist (global-var global-var-list)
       (let ((global-var-type (plist-get global-var 'ast-type)))
         (cond
          ((equal global-var-type 'simple-variable-variable)
           (let ((variable-name (plist-get global-var 'variable))
                 (variable-start (plist-get global-var 'ast-start))
                 (variable-end (plist-get global-var 'ast-end)))
             (push
              (list
               variable-name
               phps-mode-parser-sdt--bookkeeping-namespace
               variable-start
               variable-end)
              phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)))))))
   `(
     ast-type
     global-statement
     global-var-list
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 158 ((statement) (T_STATIC static_var_list ";"))
(puthash
 158
 (lambda(args _terminals)
   (let ((static-var-list (nth 1 args)))
     (dolist (static-var static-var-list)
       (let ((static-var-type (plist-get static-var 'ast-type)))
         (cond
          ((equal static-var-type 'variable)
           (let* ((variable-name (plist-get static-var 'ast-name))
                  (variable-start (plist-get static-var 'ast-start))
                  (variable-end (plist-get static-var 'ast-end)))
             (push
              (list
               variable-name
               phps-mode-parser-sdt--bookkeeping-namespace
               variable-start
               variable-end)
              phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
             (push
              (list
               variable-name
               phps-mode-parser-sdt--bookkeeping-namespace
               variable-start
               variable-end)
              phps-mode-parser-sdt--bookkeeping-symbol-stack)))))))
   `(
     ast-type
     static-statement
     static-var-list
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 159 ((statement) (T_ECHO echo_expr_list ";"))
(puthash
 159
 (lambda(args _terminals)
   `(
     ast-type
     echo-statement
     echo-expr-list
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 160 ((statement) (T_INLINE_HTML))
(puthash
 160
 (lambda(args _terminals)
   args)
 phps-mode-parser--table-translations)

;; 161 ((statement) (expr ";"))
(puthash
 161
 (lambda(args _terminals)
   `(
     ast-type
     expr-statement
     expr
     ,(nth 0 args)
     ))
 phps-mode-parser--table-translations)

;; 162 ((statement) (T_UNSET "(" unset_variables possible_comma ")" ";"))
(puthash
 162
 (lambda(args _terminals)
   (nth 0 args))
 phps-mode-parser--table-translations)

;; 163 ((statement) (T_FOREACH "(" expr T_AS foreach_variable ")" foreach_statement))
(puthash
 163
 (lambda(args _terminals)
   `(
     ast-type
     foreach-statement
     expr
     ,(nth 2 args)
     as
     ,(nth 4 args)
     foreach-statement
     ,(nth 6 args)))
 phps-mode-parser--table-translations)

;; 164 ((statement) (T_FOREACH "(" expr T_AS foreach_variable T_DOUBLE_ARROW foreach_variable ")" foreach_statement))
(puthash
 164
 (lambda(args _terminals)
   `(
     ast-type
     foreach-statement
     expr
     ,(nth 2 args)
     as
     ,(nth 4 args)
     value
     ,(nth 6 args)
     foreach-statement
     ,(nth 8 args)))
 phps-mode-parser--table-translations)

;; 165 ((statement) (T_DECLARE "(" const_list ")" declare_statement))
(puthash
 165
 (lambda(args _terminals)
   `(
     ast-type
     declare-statement
     const-list
     ,(nth 2 args)
     declare-statement
     ,(nth 4 args)
     value
     ,(nth 6 args)
     ))
 phps-mode-parser--table-translations)

;; 166 ((statement) (";"))
(puthash
 166
 (lambda(_args _terminals)
   nil)
 phps-mode-parser--table-translations)

;; 167 ((statement) (T_TRY "{" inner_statement_list "}" catch_list finally_statement))
(puthash
 167
 (lambda(args _terminals)
   `(
     ast-type
     try-statement
     inner-statement-list
     ,(nth 2 args)
     catch-list
     ,(nth 4 args)
     finally-statement
     ,(nth 5 args)))
 phps-mode-parser--table-translations)

;; 168 ((statement) (T_GOTO T_STRING ";"))
(puthash
 168
 (lambda(args _terminals)
   `(
     ast-type
     goto-statement
     label
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 169 ((statement) (T_STRING ":"))
(puthash
 169
 (lambda(args _terminals)
   `(
     ast-type
     label-statement
     label
     ,(nth 0 args)))
 phps-mode-parser--table-translations)

;; 170 ((statement) (T_VOID_CAST expr ";"))
(puthash
 170
 (lambda(args _terminals)
   `(
     ast-type
     void-cast
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 171 ((catch_list) (%empty))
(puthash 171 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 172 ((catch_list) (catch_list T_CATCH "(" catch_name_list optional_variable ")" "{" inner_statement_list "}"))
(puthash
 172
 (lambda(args terminals)
   (let ((optional-variable (nth 4 args))
         (optional-variable-start)
         (optional-variable-end))
     (when optional-variable
       (setq optional-variable-start (car (cdr (nth 4 terminals))))
       (setq optional-variable-end (cdr (cdr (nth 4 terminals))))
       (push
        (list
         optional-variable
         phps-mode-parser-sdt--bookkeeping-namespace
         optional-variable-start
         optional-variable-end)
        phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
       (push
        (list
         optional-variable
         phps-mode-parser-sdt--bookkeeping-namespace
         optional-variable-start
         optional-variable-end)
        phps-mode-parser-sdt--bookkeeping-symbol-stack))
   `(
     ast-type
     catch-list
     catch-name-list
     ,(nth 3 args)
     optional-variable
     ,optional-variable
     optional-variable-start
     ,optional-variable-start
     optional-variable-end
     ,optional-variable-end
     inner-statement-list
     ,(nth 7 args))))
 phps-mode-parser--table-translations)

;; 173 ((catch_name_list) (class_name))
(puthash
 173
 (lambda(args _terminals)
   `(
     ast-type
     catch-name-list
     class-names
     (,args)
     ))
 phps-mode-parser--table-translations)

;; 174 ((catch_name_list) (catch_name_list "|" class_name))
(puthash
 174
 (lambda(args _terminals)
   `(
     ast-type
     catch-name-list
     class-names
     ,(append (nth 0 args) (list (nth 2 args)))
     ))
 phps-mode-parser--table-translations)

;; 175 ((optional_variable) (%empty))
(puthash 175 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 176 ((optional_variable) (T_VARIABLE))
(puthash 176 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 177 ((finally_statement) (%empty))
(puthash 177 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 178 ((finally_statement) (T_FINALLY "{" inner_statement_list "}"))
(puthash
 178
 (lambda(args _terminals)
   `(
     ast-type
     finally-statement
     inner-statement-list
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 179 ((unset_variables) (unset_variable))
(puthash
 179
 (lambda(args _terminals)
   `(
     ast-type
     unset-variables
     variables
     ,(list args)
     ))
 phps-mode-parser--table-translations)

;; 180 ((unset_variables) (unset_variables "," unset_variable))
(puthash
 180
 (lambda(args _terminals)
   `(
     ast-type
     unset-variables
     variables
     ,(append (nth 0 args) (nth 2 args))
     ))
 phps-mode-parser--table-translations)

;; 181 ((unset_variable) (variable))
(puthash 181 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 182 ((function_name) (T_STRING))
;; 183 ((function_name) (T_READONLY))

;; 184 ((function_declaration_statement) (function returns_ref function_name backup_doc_comment "(" parameter_list ")" return_type backup_fn_flags "{" inner_statement_list "}" backup_fn_flags))
(puthash
 184
 (lambda(args terminals)
   ;; Iterate optional parameters are declare them as new variable declarations
   (when-let* ((parameter-list (nth 5 args)))
     (dolist (parameter parameter-list)
       (let ((parameter-ast-type (plist-get parameter 'ast-type)))
         (cond
          ((equal parameter-ast-type 'attributed-parameter)
           (let* ((attributed-parameter
                  (plist-get
                   parameter
                   'parameter))
                  (attributed-parameter-name
                   (plist-get attributed-parameter 'ast-name))
                  (symbol-name
                   attributed-parameter-name)
                  (symbol-scope
                   phps-mode-parser-sdt--bookkeeping-namespace)
                  (symbol-start
                   (plist-get attributed-parameter 'ast-start))
                  (symbol-end
                   (plist-get attributed-parameter 'ast-end)))
             (push
              (list
               symbol-name
               symbol-scope
               symbol-start
               symbol-end)
              phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
             (push
              (list
               symbol-name
               symbol-scope
               symbol-start
               symbol-end)
              phps-mode-parser-sdt--bookkeeping-symbol-stack)))))))

   ;; (message "before:")
   ;; (message
   ;;  "phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack: %S"
   ;;  phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
   ;; (message
   ;;  "phps-mode-parser-sdt--bookkeeping-symbol-stack: %S"
   ;;  phps-mode-parser-sdt--bookkeeping-symbol-stack)

   ;; Go through stacks and modify symbol namespaces
   ;; - add function scope but only for non-super-global variables
   (let ((function-name (nth 2 args))
         (function-start (car (cdr (nth 2 terminals))))
         (function-end (car (cdr (nth 11 terminals)))))

     ;; Add function to imenu stack
     (if phps-mode-parser-sdt-symbol-imenu--stack
         (push
          (list (list 'function function-name function-start function-end))
          phps-mode-parser-sdt-symbol-imenu--stack)
       (setq
        phps-mode-parser-sdt-symbol-imenu--stack
        (list (list (list 'function function-name function-start function-end)))))

     (when phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
         (let ((symbol-name (car symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (car (cdr symbol-list))))
               (push
                (list 'function function-name function-start function-end)
                symbol-scope)
               (setcar
                (cdr symbol-list)
                symbol-scope))))))
     (when phps-mode-parser-sdt--bookkeeping-symbol-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-stack)
         (let ((symbol-name (car symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (car (cdr symbol-list))))
               (push
                (list 'function function-name function-start function-end)
                symbol-scope)
               (setcar
                (cdr symbol-list)
                symbol-scope)))))))


   ;; (message "after:")
   ;; (message
   ;;  "phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack: %S"
   ;;  phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
   ;; (message
   ;;  "phps-mode-parser-sdt--bookkeeping-symbol-stack: %S"
   ;;  phps-mode-parser-sdt--bookkeeping-symbol-stack)


   `(
     ast-type
     function
     ast-name
     ,(nth 2 args)
     ast-index
     ,(car (cdr (nth 2 terminals)))
     ast-start
     ,(car (cdr (nth 9 terminals)))
     ast-end
     ,(car (cdr (nth 11 terminals)))
     returns-reference-p
     ,(not (equal (nth 1 args) nil))
     parameter-list
     ,(nth 5 args)
     return-type
     ,(nth 7 args)
     inner-statement-list
     ,(nth 10 args)
     ))
 phps-mode-parser--table-translations)

;; 185 ((is_reference) (%empty))
(puthash 185 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 186 ((is_reference) (T_AMPERSAND_FOLLOWED_BY_VAR_OR_VARARG))
(puthash 186 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 187 ((is_variadic) (%empty))
(puthash 187 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 188 ((is_variadic) (T_ELLIPSIS))
(puthash 188 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 189 ((class_declaration_statement) (class_modifiers T_CLASS T_STRING extends_from implements_list backup_doc_comment "{" class_statement_list "}"))
(puthash
 189
 (lambda(args terminals)
   ;; Go through stacks and modify symbol name-spaces
   ;; but only for non-super-global variables.
   ;; 
   ;; Should place class scope first in scope
   ;; unless a namespace exists, in that case it should be placed second in scope
   (let ((class-name (nth 2 args))
         (class-start (car (cdr (nth 2 terminals))))
         (class-end (cdr (cdr (nth 8 terminals)))))

     ;; Add class scope to all functions in class
     (when phps-mode-parser-sdt-symbol-imenu--stack
       (let ((imenu-stack-count
              (length phps-mode-parser-sdt-symbol-imenu--stack))
             (imenu-stack-index 0))
         (while (< imenu-stack-index imenu-stack-count)
           (let* ((items (nth imenu-stack-index phps-mode-parser-sdt-symbol-imenu--stack))
                  (item-count (length items))
                  (item-index 0))
             (while (< item-index item-count)
               (let* ((item (nth item-index items))
                      (item-start (nth 2 item)))
                 (when (and
                        (>= item-start class-start)
                        (<= item-start class-end))
                   (push
                    (list 'class class-name class-start class-end)
                    (nth imenu-stack-index phps-mode-parser-sdt-symbol-imenu--stack))
                   (setq item-index item-count)))
               (setq item-index (1+ item-index))))
           (setq imenu-stack-index (1+ imenu-stack-index)))))

     ;; Add class to imenu stack
     (if phps-mode-parser-sdt-symbol-imenu--stack
         (push
          (list (list 'class class-name class-start class-end))
          phps-mode-parser-sdt-symbol-imenu--stack)
       (setq
        phps-mode-parser-sdt-symbol-imenu--stack
        (list (list (list 'class class-name class-start class-end)))))

     (when phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
         (let ((symbol-name (car symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (reverse (car (cdr symbol-list)))))
               (if (equal (car (car symbol-scope)) 'namespace)
                   (let ((namespace-name (nth 1 (car symbol-scope)))
                         (namespace-start (nth 2 (car symbol-scope)))
                         (namespace-end (nth 3 (car symbol-scope))))
                     (setcar
                      symbol-scope
                      (list 'class class-name class-start class-end))
                     (push
                      (list 'namespace namespace-name namespace-start namespace-end)
                      symbol-scope))
                 (push
                  (list 'class class-name class-start class-end)
                  symbol-scope))
               (setcar
                (cdr symbol-list)
                (reverse symbol-scope)))))))

     (when phps-mode-parser-sdt--bookkeeping-symbol-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-stack)
         (let ((symbol-name (car symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (reverse (car (cdr symbol-list)))))
               (if (equal (car (car symbol-scope)) 'namespace)
                   (let ((namespace-name (nth 1 (car symbol-scope)))
                         (namespace-start (nth 2 (car symbol-scope)))
                         (namespace-end (nth 3 (car symbol-scope))))
                     (setcar
                      symbol-scope
                      (list 'class class-name class-start class-end))
                     (push
                      (list 'namespace namespace-name namespace-start namespace-end)
                      symbol-scope))
                 (push
                  (list 'class class-name class-start class-end)
                  symbol-scope))
               (setcar
                (cdr symbol-list)
                (reverse symbol-scope))))))))

   `(
     ast-type
     class
     modifiers
     ,(nth 0 args)
     ast-name
     ,(nth 2 args)
     extends-from
     ,(nth 3 args)
     implements-list
     ,(nth 4 args)
     ast-index
     ,(car (cdr (nth 2 terminals)))
     ast-start
     ,(car (cdr (nth 6 terminals)))
     ast-end
     ,(car (cdr (nth 8 terminals)))
     class-statement-list
     ,(nth 7 args)
     ))
 phps-mode-parser--table-translations)

;; 190 ((class_declaration_statement) (T_CLASS T_STRING extends_from implements_list backup_doc_comment "{" class_statement_list "}"))
(puthash
 190
 (lambda(args terminals)
   ;; Go through stacks and modify symbol name-spaces
   ;; but only for non-super-global variables.
   ;; 
   ;; Should place class scope first in scope
   ;; unless a namespace exists, in that case it should be placed second in scope
   (let ((class-name (nth 1 args))
         (class-start (car (cdr (nth 1 terminals))))
         (class-end (cdr (cdr (nth 7 terminals)))))

     ;; Add class scope to all functions in class
     (when phps-mode-parser-sdt-symbol-imenu--stack
       (let ((imenu-stack-count
              (length phps-mode-parser-sdt-symbol-imenu--stack))
             (imenu-stack-index 0))
         (while (< imenu-stack-index imenu-stack-count)
           (let* ((items (nth imenu-stack-index phps-mode-parser-sdt-symbol-imenu--stack))
                  (item-count (length items))
                  (item-index 0))
             (while (< item-index item-count)
               (let* ((item (nth item-index items))
                      (item-start (nth 2 item)))
                 (when (and
                        (>= item-start class-start)
                        (<= item-start class-end))
                   (push
                    (list 'class class-name class-start class-end)
                    (nth imenu-stack-index phps-mode-parser-sdt-symbol-imenu--stack))
                   (setq item-index item-count)))
               (setq item-index (1+ item-index))))
           (setq imenu-stack-index (1+ imenu-stack-index)))))

     ;; Add class to imenu stack
     (if phps-mode-parser-sdt-symbol-imenu--stack
         (push
          (list (list 'class class-name class-start class-end))
          phps-mode-parser-sdt-symbol-imenu--stack)
       (setq
        phps-mode-parser-sdt-symbol-imenu--stack
        (list (list (list 'class class-name class-start class-end)))))

     (when phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
         (let ((symbol-name (car symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (reverse (car (cdr symbol-list)))))
               (if (equal (car (car symbol-scope)) 'namespace)
                   (let ((namespace-name (nth 1 (car symbol-scope)))
                         (namespace-start (nth 2 (car symbol-scope)))
                         (namespace-end (nth 3 (car symbol-scope))))
                     (setcar
                      symbol-scope
                      (list 'class class-name class-start class-end))
                     (push
                      (list 'namespace namespace-name namespace-start namespace-end)
                      symbol-scope))
                 (push
                  (list 'class class-name class-start class-end)
                  symbol-scope))
               (setcar
                (cdr symbol-list)
                (reverse symbol-scope)))))))

     (when phps-mode-parser-sdt--bookkeeping-symbol-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-stack)
         (let ((symbol-name (car symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (reverse (car (cdr symbol-list)))))
               (if (equal (car (car symbol-scope)) 'namespace)
                   (let ((namespace-name (nth 1 (car symbol-scope)))
                         (namespace-start (nth 2 (car symbol-scope)))
                         (namespace-end (nth 3 (car symbol-scope))))
                     (setcar
                      symbol-scope
                      (list 'class class-name class-start class-end))
                     (push
                      (list 'namespace namespace-name namespace-start namespace-end)
                      symbol-scope))
                 (push
                  (list 'class class-name class-start class-end)
                  symbol-scope))
               (setcar
                (cdr symbol-list)
                (reverse symbol-scope))))))))

   `(
     ast-type
     class
     ast-name
     ,(nth 1 args)
     extends-from
     ,(nth 2 args)
     implements-list
     ,(nth 3 args)
     ast-index
     ,(car (cdr (nth 1 terminals)))
     ast-start
     ,(car (cdr (nth 5 terminals)))
     ast-end
     ,(car (cdr (nth 7 terminals)))
     class-statement-list
     ,(nth 6 args)))
 phps-mode-parser--table-translations)

;; 191 ((class_modifiers) (class_modifier))
(puthash 191 (lambda(args _terminals) `(,args)) phps-mode-parser--table-translations)

;; 192 ((class_modifiers) (class_modifiers class_modifier))
(puthash 192 (lambda(args _terminals) `(append ,(nth 0 args) (,(nth 1 args)))) phps-mode-parser--table-translations)

;; 193 ((anonymous_class_modifiers) (class_modifier))
(puthash 193 (lambda(args _terminals) `(,args)) phps-mode-parser--table-translations)

;; 194 ((anonymous_class_modifiers) (anonymous_class_modifiers class_modifier))
(puthash 194 (lambda(args _terminals) `(append ,(nth 0 args) (,(nth 1 args)))) phps-mode-parser--table-translations)

;; 195 ((anonymous_class_modifiers_optional) (%empty))
(puthash 195 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 196 ((anonymous_class_modifiers_optional) (anonymous_class_modifiers))
(puthash 196 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 197 ((class_modifier) (T_ABSTRACT))
(puthash 197 (lambda(_args _terminals) 'T_ABSTRACT) phps-mode-parser--table-translations)

;; 198 ((class_modifier) (T_FINAL))
(puthash 198 (lambda(_args _terminals) 'T_FINAL) phps-mode-parser--table-translations)

;; 199 ((class_modifier) (T_READONLY))
(puthash 199 (lambda(_args _terminals) 'T_READONLY) phps-mode-parser--table-translations)

;; 200 ((trait_declaration_statement) (T_TRAIT T_STRING backup_doc_comment "{" class_statement_list "}"))
(puthash
 200
 (lambda(args terminals)
   ;; Go through stacks and modify symbol name-spaces
   ;; but only for non-super-global variables.
   ;; 
   ;; Should place class scope first in scope
   ;; unless a namespace exists, in that case it should be placed second in scope
   (let ((class-name (nth 1 args))
         (class-start (car (cdr (nth 1 terminals))))
         (class-end (cdr (cdr (nth 5 terminals)))))

     ;; Add class scope to all functions in class
     (when phps-mode-parser-sdt-symbol-imenu--stack
       (let ((imenu-stack-count
              (length phps-mode-parser-sdt-symbol-imenu--stack))
             (imenu-stack-index 0))
         (while (< imenu-stack-index imenu-stack-count)
           (let* ((items (nth imenu-stack-index phps-mode-parser-sdt-symbol-imenu--stack))
                  (item-count (length items))
                  (item-index 0))
             (while (< item-index item-count)
               (let* ((item (nth item-index items))
                      (item-start (nth 2 item)))
                 (when (and
                        (>= item-start class-start)
                        (<= item-start class-end))
                   (push
                    (list 'trait class-name class-start class-end)
                    (nth imenu-stack-index phps-mode-parser-sdt-symbol-imenu--stack))
                   (setq item-index item-count)))
               (setq item-index (1+ item-index))))
           (setq imenu-stack-index (1+ imenu-stack-index)))))

     ;; Add class to imenu stack
     (if phps-mode-parser-sdt-symbol-imenu--stack
         (push
          (list (list 'trait class-name class-start class-end))
          phps-mode-parser-sdt-symbol-imenu--stack)
       (setq
        phps-mode-parser-sdt-symbol-imenu--stack
        (list (list (list 'trait class-name class-start class-end)))))

     (when phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
         (let ((symbol-name (car symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (reverse (car (cdr symbol-list)))))
               (if (equal (car (car symbol-scope)) 'namespace)
                   (let ((namespace-name (nth 1 (car symbol-scope)))
                         (namespace-start (nth 2 (car symbol-scope)))
                         (namespace-end (nth 3 (car symbol-scope))))
                     (setcar
                      symbol-scope
                      (list 'trait class-name class-start class-end))
                     (push
                      (list 'namespace namespace-name namespace-start namespace-end)
                      symbol-scope))
                 (push
                  (list 'trait class-name class-start class-end)
                  symbol-scope))
               (setq symbol-scope (reverse symbol-scope))
               (setcar
                (cdr symbol-list)
                symbol-scope))))))

     (when phps-mode-parser-sdt--bookkeeping-symbol-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-stack)
         (let ((symbol-name (car symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (reverse (car (cdr symbol-list)))))
               (if (equal (car (car symbol-scope)) 'namespace)
                   (let ((namespace-name (nth 1 (car symbol-scope)))
                         (namespace-start (nth 2 (car symbol-scope)))
                         (namespace-end (nth 3 (car symbol-scope))))
                     (setcar
                      symbol-scope
                      (list 'trait class-name class-start class-end))
                     (push
                      (list 'namespace namespace-name namespace-start namespace-end)
                      symbol-scope))
                 (push
                  (list 'trait class-name class-start class-end)
                  symbol-scope))
               (setq symbol-scope (reverse symbol-scope))
               (setcar
                (cdr symbol-list)
                symbol-scope)))))))

   `(
     ast-type
     trait-declaration-statement
     ast-name
     ,(nth 1 args)
     backup-doc-comment
     ,(nth 2 args)
     class-statement-list
     ,(nth 4 args)))
 phps-mode-parser--table-translations)

;; 201 ((interface_declaration_statement) (T_INTERFACE T_STRING interface_extends_list backup_doc_comment "{" class_statement_list "}"))
(puthash
 201
 (lambda(args terminals)
   ;; Go through stacks and modify symbol name-spaces
   ;; but only for non-super-global variables.
   ;; 
   ;; Should place class scope first in scope
   ;; unless a namespace exists, in that case it should be placed second in scope
   (let ((class-name (nth 1 args))
         (class-start (car (cdr (nth 1 terminals))))
         (class-end (cdr (cdr (nth 6 terminals)))))

     ;; Add class scope to all functions in class
     (when phps-mode-parser-sdt-symbol-imenu--stack
       (let ((imenu-stack-count
              (length phps-mode-parser-sdt-symbol-imenu--stack))
             (imenu-stack-index 0))
         (while (< imenu-stack-index imenu-stack-count)
           (let* ((items (nth imenu-stack-index phps-mode-parser-sdt-symbol-imenu--stack))
                  (item-count (length items))
                  (item-index 0))
             (while (< item-index item-count)
               (let* ((item (nth item-index items))
                      (item-start (nth 2 item)))
                 (when (and
                        (>= item-start class-start)
                        (<= item-start class-end))
                   (push
                    (list 'interface class-name class-start class-end)
                    (nth imenu-stack-index phps-mode-parser-sdt-symbol-imenu--stack))
                   (setq item-index item-count)))
               (setq item-index (1+ item-index))))
           (setq imenu-stack-index (1+ imenu-stack-index)))))

     ;; Add class to imenu stack
     (if phps-mode-parser-sdt-symbol-imenu--stack
         (push
          (list (list 'interface class-name class-start class-end))
          phps-mode-parser-sdt-symbol-imenu--stack)
       (setq
        phps-mode-parser-sdt-symbol-imenu--stack
        (list (list (list 'interface class-name class-start class-end)))))

     (when phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
         (let ((symbol-name (car symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (reverse (car (cdr symbol-list)))))
               (if (equal (car (car symbol-scope)) 'namespace)
                   (let ((namespace-name (nth 1 (car symbol-scope)))
                         (namespace-start (nth 2 (car symbol-scope)))
                         (namespace-end (nth 3 (car symbol-scope))))
                     (setcar
                      symbol-scope
                      (list 'interface class-name class-start class-end))
                     (push
                      (list 'namespace namespace-name namespace-start namespace-end)
                      symbol-scope))
                 (push
                  (list 'interface class-name class-start class-end)
                  symbol-scope))
               (setq symbol-scope (reverse symbol-scope))
               (setcar
                (cdr symbol-list)
                symbol-scope))))))

     (when phps-mode-parser-sdt--bookkeeping-symbol-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-stack)
         (let ((symbol-name (car symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (reverse (car (cdr symbol-list)))))
               (if (equal (car (car symbol-scope)) 'namespace)
                   (let ((namespace-name (nth 1 (car symbol-scope)))
                         (namespace-start (nth 2 (car symbol-scope)))
                         (namespace-end (nth 3 (car symbol-scope))))
                     (setcar
                      symbol-scope
                      (list 'interface class-name class-start class-end))
                     (push
                      (list 'namespace namespace-name namespace-start namespace-end)
                      symbol-scope))
                 (push
                  (list 'interface class-name class-start class-end)
                  symbol-scope))
               (setq symbol-scope (reverse symbol-scope))
               (setcar
                (cdr symbol-list)
                symbol-scope)))))))

   `(
     ast-type
     interface-declaration-statement
     ast-name
     ,(nth 1 args)
     interface-extends-list
     ,(nth 2 args)
     ast-index
     ,(car (cdr (nth 1 terminals)))
     ast-start
     ,(car (cdr (nth 4 terminals)))
     ast-end
     ,(car (cdr (nth 6 terminals)))
     class-statement-list
     ,(nth 5 args)
     ))
 phps-mode-parser--table-translations)

;; 202 ((enum_declaration_statement) (T_ENUM T_STRING enum_backing_type implements_list backup_doc_comment "{" class_statement_list "}"))
(puthash
 202
 (lambda(args terminals)
   `(
     ast-type
     enum-declaration-statement
     ast-name
     ,(nth 1 args)
     enum-backing-type
     ,(nth 2 args)
     implements-list
     ,(nth 3 args)
     ast-index
     ,(car (cdr (nth 1 terminals)))
     ast-start
     ,(car (cdr (nth 5 terminals)))
     ast-end
     ,(car (cdr (nth 7 terminals)))
     class-statement-list
     ,(nth 6 args)
     ))
 phps-mode-parser--table-translations)

;; 203 ((enum_backing_type) (%empty))
(puthash 203 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 204 ((enum_backing_type) (":" type_expr))
(puthash 204 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 205 ((enum_case) (T_CASE backup_doc_comment identifier enum_case_expr ";"))
(puthash
 205
 (lambda(args _terminals)
   `(
     ast-type
     enum-case
     backup-doc-comment
     ,(nth 1 args)
     identifier
     ,(nth 2 args)
     enum-case-expr
     ,(nth 3 args)
     ))
 phps-mode-parser--table-translations)

;; 206 ((enum_case_expr) (%empty))
(puthash 206 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 207 ((enum_case_expr) ("=" expr))
(puthash
 207
 (lambda(args _terminals)
   `(
     ast-type
     enum-case-expr
     expr
     ,(nth 1 args)
     )
   )
 phps-mode-parser--table-translations)

;; 208 ((extends_from) (%empty))
(puthash 208 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 209 ((extends_from) (T_EXTENDS class_name))
(puthash
 209
 (lambda(args _terminals)
   `(
     ast-type
     extends-from
     class-name
     ,(nth 1 args)
     )
   )
 phps-mode-parser--table-translations)

;; 210 ((interface_extends_list) (%empty))
(puthash 210 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 211 ((interface_extends_list) (T_EXTENDS class_name_list))
(puthash
 211
 (lambda(args _terminals)
   `(
     ast-type
     interface-extends-list
     class-name-list
     ,(nth 1 args)
     )
   )
 phps-mode-parser--table-translations)

;; 212 ((implements_list) (%empty))
(puthash 212 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 213 ((implements_list) (T_IMPLEMENTS class_name_list))
(puthash
 213
 (lambda(args _terminals)
   `(
     ast-type
     implements-list
     class-name-list
     ,(nth 1 args)
     )
   )
 phps-mode-parser--table-translations)

;; 214 ((foreach_variable) (variable))
(puthash
 214
 (lambda(args terminals)
   ;; Save variable declaration in bookkeeping buffer
   (let ((variable-type (plist-get args 'ast-type)))
     (cond
      ((equal variable-type 'variable-callable-variable)
       (let* ((callable-variable (plist-get args 'callable-variable))
              (callable-variable-type (plist-get callable-variable 'ast-type)))
         (cond
          ((equal callable-variable-type 'callable-variable-simple-variable)
           (let ((callable-variable-simple-variable
                  (plist-get callable-variable 'simple-variable)))
             (let ((callable-variable-simple-variable-type
                    (plist-get
                     callable-variable-simple-variable
                     'ast-type)))
               (cond
                ((equal
                  callable-variable-simple-variable-type
                  'simple-variable-variable)
                 (let* ((variable-name
                         (plist-get
                          callable-variable-simple-variable
                          'variable))
                        (symbol-name
                         variable-name)
                        (symbol-start
                         (car (cdr terminals)))
                        (symbol-end
                         (cdr (cdr terminals)))
                        (symbol-scope
                         phps-mode-parser-sdt--bookkeeping-namespace))
                   ;; (message "declared foreach variable from terminals: %S" terminals)
                   (push
                    (list
                     symbol-name
                     symbol-scope
                     symbol-start
                     symbol-end)
                    phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))))))))))))

   `(
     ast-type
     foreach-variable
     variable
     ,args))
 phps-mode-parser--table-translations)

;; 215 ((foreach_variable) (ampersand variable))
(puthash
 215
 (lambda(args terminals)
   ;; Save variable declaration in bookkeeping buffer
   (let* ((variable (nth 1 args))
          (variable-type (plist-get variable 'ast-type)))
     (cond
      ((equal variable-type 'variable-callable-variable)
       (let* ((callable-variable (plist-get variable 'callable-variable))
              (callable-variable-type (plist-get callable-variable 'ast-type)))
         (cond
          ((equal callable-variable-type 'callable-variable-simple-variable)
           (let ((callable-variable-simple-variable
                  (plist-get callable-variable 'simple-variable)))
             (let ((callable-variable-simple-variable-type
                    (plist-get
                     callable-variable-simple-variable
                     'ast-type)))
               (cond
                ((equal
                  callable-variable-simple-variable-type
                  'simple-variable-variable)
                 (let* ((variable-name
                         (plist-get
                          callable-variable-simple-variable
                          'variable))
                        (symbol-name
                         variable-name)
                        (symbol-start
                         (car (cdr (nth 1 terminals))))
                        (symbol-end
                         (cdr (cdr (nth 1 terminals))))
                        (symbol-scope
                         phps-mode-parser-sdt--bookkeeping-namespace))
                   ;; (message "declared foreach variable from terminals: %S" (nth 1 terminals))
                   (push
                    (list
                     symbol-name
                     symbol-scope
                     symbol-start
                     symbol-end)
                    phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))))))))))))

   `(
     ast-type
     foreach-referenced-variable
     variable
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 216 ((foreach_variable) (T_LIST "(" array_pair_list ")"))
(puthash
 216
 (lambda(args _terminals)
   ;; TODO Declare variable here

   `(
     ast-type
     foreach-list-variable
     array-pair-list
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 217 ((foreach_variable) ("[" array_pair_list "]"))
(puthash
 217
 (lambda(args _terminals)
   ;; TODO Declare variable here

   `(
     ast-type
     foreach-variable
     array-pair-list
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 218 ((for_statement) (statement))
(puthash
 218
 (lambda(args _terminals)
   `(
     ast-type
     for-statement
     statement
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 219 ((for_statement) (":" inner_statement_list T_ENDFOR ";"))
(puthash
 219
 (lambda(args _terminals)
   `(
     ast-type
     for-statement
     inner-statement-list
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 220 ((foreach_statement) (statement))
(puthash
 220
 (lambda(args _terminals)
   `(
     ast-type
     foreach-statement
     statement
     ,args))
 phps-mode-parser--table-translations)

;; 221 ((foreach_statement) (":" inner_statement_list T_ENDFOREACH ";"))
(puthash
 221
 (lambda(args _terminals)
   `(
     ast-type
     foreach-statement
     inner-statement-list
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 222 ((declare_statement) (statement))
(puthash
 222
 (lambda(args _terminals)
   `(
     ast-type
     declare-statement
     statement
     ,args
     ))
 phps-mode-parser--table-translations)

;; 223 ((declare_statement) (":" inner_statement_list T_ENDDECLARE ";"))
(puthash
 223
 (lambda(args _terminals)
   `(
     ast-type
     declare-statement
     inner-statement-list
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 224 ((switch_case_list) ("{" case_list "}"))
(puthash 224 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 225 ((switch_case_list) ("{" ";" case_list "}"))
(puthash 225 (lambda(args _terminals) (nth 2 args)) phps-mode-parser--table-translations)

;; 226 ((switch_case_list) (":" case_list T_ENDSWITCH ";"))
(puthash 226 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 227 ((switch_case_list) (":" ";" case_list T_ENDSWITCH ";"))
(puthash 227 (lambda(args _terminals) (nth 2 args)) phps-mode-parser--table-translations)

;; 228 ((case_list) (%empty))
(puthash 228 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 229 ((case_list) (case_list T_CASE expr case_separator inner_statement_list))
(puthash
 229
 (lambda(args _terminals)
   `(
     ast-type
     expr-case-list
     expr
     ,(nth 2 args)
     inner-statement-list
     ,(nth 4 args)))
 phps-mode-parser--table-translations)

;; 230 ((case_list) (case_list T_DEFAULT case_separator inner_statement_list))
(puthash
 230
 (lambda(args _terminals)
   `(
     ast-type
     default-case-list
     inner-statement-list
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 231 ((case_separator) (":"))
(puthash 231 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 232 ((case_separator) (";"))
(puthash 232 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 233 ((match) (T_MATCH "(" expr ")" "{" match_arm_list "}"))
(puthash
 233
 (lambda(args _terminals)
   `(
     ast-type
     match
     expr
     ,(nth 2 args)
     match-arm-list
     ,(nth 5 args)
     ))
 phps-mode-parser--table-translations)

;; 234 ((match_arm_list) (%empty))
(puthash 234 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 235 ((match_arm_list) (non_empty_match_arm_list possible_comma))
(puthash 235 (lambda(args _terminals) (nth 0 args)) phps-mode-parser--table-translations)

;; 236 ((non_empty_match_arm_list) (match_arm))
(puthash 236 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 237 ((non_empty_match_arm_list) (non_empty_match_arm_list "," match_arm))
(puthash
 237
 (lambda(args _terminals)
   (append (nth 0 args) (list (nth 2 args))))
 phps-mode-parser--table-translations)

;; 238 ((match_arm) (match_arm_cond_list possible_comma T_DOUBLE_ARROW expr))
(puthash
 238
 (lambda(args _terminals)
   `(
     ast-type
     cond-match-arm
     match-arm-cond-list
     ,(nth 0 args)
     expr
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 239 ((match_arm) (T_DEFAULT possible_comma T_DOUBLE_ARROW expr))
(puthash
 239
 (lambda(args _terminals)
   `(
     ast-type
     default-match-arm
     expr
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 240 ((match_arm_cond_list) (expr))
(puthash 240 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 241 ((match_arm_cond_list) (match_arm_cond_list "," expr))
(puthash 241 (lambda(args _terminals) (append (nth 0 args) (list (nth 2 args)))) phps-mode-parser--table-translations)

;; 242 ((while_statement) (statement))
(puthash 242 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 243 ((while_statement) (":" inner_statement_list T_ENDWHILE ";"))
(puthash 243 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 244 ((if_stmt_without_else) (T_IF "(" expr ")" statement))
(puthash
 244
 (lambda(args _terminals)
   `(
     ast-type
     if-stmt-without-else
     if-condition
     ,(nth 2 args)
     statement
     ,(nth 4 args)
     ))
 phps-mode-parser--table-translations)

;; 245 ((if_stmt_without_else) (if_stmt_without_else T_ELSEIF "(" expr ")" statement))
(puthash
 245
 (lambda(args _terminals)
   `(
     ast-type
     if-elseif-stmt-without-else
     if-stmt-without-else
     ,(nth 0 args)
     elseif-condition
     ,(nth 3 args)
     statement
     ,(nth 5 args)
     ))
 phps-mode-parser--table-translations)

;; 246 ((if_stmt) (if_stmt_without_else))
(puthash 246 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 247 ((if_stmt) (if_stmt_without_else T_ELSE statement))
(puthash
 247
 (lambda(args _terminals)
   `(
     ast-type
     if-else-stmt
     if-stmt-without-else
     ,(nth 0 args)
     else-statement
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 248 ((alt_if_stmt_without_else) (T_IF "(" expr ")" ":" inner_statement_list))
(puthash
 248
 (lambda(args _terminals)
   `(
     ast-type
     alt-if-stmt-without-else
     if-condition
     ,(nth 2 args)
     inner-statement-list
     ,(nth 5 args)
     ))
 phps-mode-parser--table-translations)

;; 249 ((alt_if_stmt_without_else) (alt_if_stmt_without_else T_ELSEIF "(" expr ")" ":" inner_statement_list))
(puthash
 249
 (lambda(args _terminals)
   `(
     ast-type
     alt-if-stmt-without-else-elseif
     alt-if-stmt-without-else
     ,(nth 2 args)
     elseif-condition
     ,(nth 3 args)
     inner-statement-list
     ,(nth 6 args)
     ))
 phps-mode-parser--table-translations)

;; 250 ((alt_if_stmt) (alt_if_stmt_without_else T_ENDIF ";"))
(puthash 250 (lambda(args _terminals) (nth 0 args)) phps-mode-parser--table-translations)

;; 251 ((alt_if_stmt) (alt_if_stmt_without_else T_ELSE ":" inner_statement_list T_ENDIF ";"))
(puthash
 251
 (lambda(args _terminals)
   `(
     ast-type
     alt-if-stmt-else
     alt-if-stmt-without-else
     ,(nth 0 args)
     inner-statement-list
     ,(nth 3 args)
     ))
 phps-mode-parser--table-translations)

;; 252 ((parameter_list) (non_empty_parameter_list possible_comma))
(puthash 252 (lambda(args _terminals) (nth 0 args)) phps-mode-parser--table-translations)

;; 253 ((parameter_list) (%empty))
(puthash 253 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 254 ((non_empty_parameter_list) (attributed_parameter))
(puthash 254 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 255 ((non_empty_parameter_list) (non_empty_parameter_list "," attributed_parameter))
(puthash 255 (lambda(args _terminals) (append (nth 0 args) (list (nth 2 args)))) phps-mode-parser--table-translations)

;; 256 ((attributed_parameter) (attributes parameter))
(puthash
 256
 (lambda(args _terminals)
   `(
     ast-type
     attributed-parameter
     attributes
     ,(nth 0 args)
     parameter
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 257 ((attributed_parameter) (parameter))
(puthash
 257
 (lambda(args _terminals)
   `(
     ast-type
     attributed-parameter
     parameter
     ,args
     ))
 phps-mode-parser--table-translations)

;; 258 ((optional_cpp_modifiers) (%empty))
(puthash 258 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 259 ((optional_cpp_modifiers) (non_empty_member_modifiers))
(puthash 259 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 260 ((parameter) (optional_property_modifiers optional_type_without_static is_reference is_variadic T_VARIABLE backup_doc_comment))
(puthash
 260
 (lambda(args terminals)
   `(
     ast-type
     parameter
     visibility
     ,(nth 0 args)
     type
     ,(nth 1 args)
     is-reference
     ,(if (nth 2 args) t nil)
     is-variadic
     ,(if (nth 3 args) t nil)
     ast-name
     ,(nth 4 args)
     ast-start
     ,(car (cdr (nth 4 terminals)))
     ast-end
     ,(cdr (cdr (nth 4 terminals)))
     ))
 phps-mode-parser--table-translations)

;; 261 ((parameter) (optional_property_modifiers optional_type_without_static is_reference is_variadic T_VARIABLE backup_doc_comment "=" expr))
(puthash
 261
 (lambda(args terminals)
   `(
     ast-type
     parameter-with-default-value
     visibility
     ,(nth 0 args)
     type
     ,(nth 1 args)
     is-reference
     ,(if (nth 2 args) t nil)
     is-variadic
     ,(if (nth 3 args) t nil)
     ast-name
     ,(nth 4 args)
     ast-start
     ,(car (cdr (nth 4 terminals)))
     ast-end
     ,(cdr (cdr (nth 4 terminals)))
     backup-doc-comment
     ,(nth 5 args)
     default-value
     ,(nth 7 args)
     ))
 phps-mode-parser--table-translations)

;; 262 ((optional_type_without_static) (%empty))
(puthash 262 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 263 ((optional_type_without_static) (type_expr_without_static))
(puthash 263 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 264 ((type_expr) (type))
(puthash
 264
 (lambda(args _terminals)
   `(
     ast-type
     plain-type
     type
     ,args
     ))
 phps-mode-parser--table-translations)

;; 265 ((type_expr) ("?" type))
(puthash
 265
 (lambda(args _terminals)
   `(
     ast-type
     nullable-type
     type
     ,args
     ))
 phps-mode-parser--table-translations)

;; 266 ((type_expr) (union_type))
(puthash
 266
 (lambda(args _terminals)
   `(
     ast-type
     union-type
     type
     ,args
     ))
 phps-mode-parser--table-translations)

;; 267 ((type_expr) (intersection_type))
(puthash
 267
 (lambda(args _terminals)
   `(
     ast-type
     intersection-type
     type
     ,args
     ))
 phps-mode-parser--table-translations)

;; 268 ((type) (type_without_static))
(puthash 268 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 269 ((type) (T_STATIC))
(puthash 269 (lambda(_args _terminals) 'T_STATIC) phps-mode-parser--table-translations)

;; 270 ((union_type_element) (type))
(puthash
 270
 (lambda(args _terminals)
   `(
     ast-type
     simple-union-type-element
     type
     ,args
     ))
 phps-mode-parser--table-translations)

;; 271 ((union_type_element) ("(" intersection_type ")"))
(puthash
 271
 (lambda(args _terminals)
   `(
     ast-type
     intersection-union-type-element
     type
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 272 ((union_type) (union_type_element "|" union_type_element))
(puthash
 272
 (lambda(args _terminals)
   (list (nth 0 args) (nth 2 args)))
 phps-mode-parser--table-translations)

;; 273 ((union_type) (union_type "|" union_type_element))
(puthash
 273
 (lambda(args _terminals)
   (append (nth 0 args) (list (nth 2 args))))
 phps-mode-parser--table-translations)

;; 274 ((intersection_type) (type T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG type))
(puthash 274 (lambda(args _terminals) (list (nth 0 args) (nth 2 args))) phps-mode-parser--table-translations)

;; 275 ((intersection_type) (intersection_type T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG type))
(puthash 275 (lambda(args _terminals) (append (nth 0 args) (list (nth 1 args)))) phps-mode-parser--table-translations)

;; 276 ((type_expr_without_static) (type_without_static))
(puthash 276 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 277 ((type_expr_without_static) ("?" type_without_static))
(puthash 277 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 278 ((type_expr_without_static) (union_type_without_static))
(puthash 278 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 279 ((type_expr_without_static) (intersection_type_without_static))
(puthash 279 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 280 ((type_without_static) (T_ARRAY))
(puthash 280 (lambda(_args _terminals) 'T_ARRAY) phps-mode-parser--table-translations)

;; 281 ((type_without_static) (T_CALLABLE))
(puthash 281 (lambda(_args _terminals) 'T_CALLABLE) phps-mode-parser--table-translations)

;; 282 ((type_without_static) (name))
(puthash 282 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 283 ((union_type_without_static_element) (type_without_static))
(puthash 283 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 284 ((union_type_without_static_element) ("(" intersection_type_without_static ")"))
(puthash 284 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 285 ((union_type_without_static) (union_type_without_static_element "|" union_type_without_static_element))
(puthash 285 (lambda(args _terminals) (list (nth 0 args) (nth 2 args))) phps-mode-parser--table-translations)

;; 286 ((union_type_without_static) (union_type_without_static "|" union_type_without_static_element))
(puthash 286 (lambda(args _terminals) (list (nth 0 args) (nth 2 args))) phps-mode-parser--table-translations)

;; 287 ((intersection_type_without_static) (type_without_static T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG type_without_static))
(puthash 287 (lambda(args _terminals) (list (nth 0 args) (nth 2 args))) phps-mode-parser--table-translations)

;; 288 ((intersection_type_without_static) (intersection_type_without_static T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG type_without_static))
(puthash 288 (lambda(args _terminals) (list (nth 0 args) (nth 2 args))) phps-mode-parser--table-translations)

;; 289 ((return_type) (%empty))
(puthash 289 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 290 ((return_type) (":" type_expr))
(puthash 290 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 291 ((argument_list) ("(" ")"))
(puthash 291 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 292 ((argument_list) ("(" non_empty_argument_list possible_comma ")"))
(puthash 292 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 293 ((argument_list) ("(" T_ELLIPSIS ")"))
(puthash 293 (lambda(_args _terminals) 'T_ELLIPSIS) phps-mode-parser--table-translations)

;; 294 ((non_empty_argument_list) (argument))
(puthash 294 (lambda(args _terminals) (list (nth 0 args))) phps-mode-parser--table-translations)

;; 295 ((non_empty_argument_list) (non_empty_argument_list "," argument))
(puthash 295 (lambda(args _terminals) (append (nth 0 args) (list (nth 2 args)))) phps-mode-parser--table-translations)

;; 296 ((clone_argument_list) ("(" ")"))
(puthash 296 (lambda(_args _terminals) (list)) phps-mode-parser--table-translations)

;; 297 ((clone_argument_list) ("(" non_empty_clone_argument_list possible_comma ")"))
(puthash 297 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 298 ((clone_argument_list) ("(" expr "," ")"))
(puthash 298 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 299 ((clone_argument_list) ("(" T_ELLIPSIS ")"))
(puthash
 299
 (lambda(_args _terminals)
   `(
     ast-type
     clone-argument-ellipsis
     ))
 phps-mode-parser--table-translations)

;; 300 ((non_empty_clone_argument_list) (expr "," argument))
(puthash
 300
 (lambda(args _terminals)
   `(
     ast-type
     clone-expr-argument
     expr
     ,(nth 0 args)
     argument
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 301 ((non_empty_clone_argument_list) (argument_no_expr))
(puthash
 301
 (lambda(args _terminals)
   `(
     ast-type
     clone-argument
     expr
     ,(nth 0 args)
     ))
 phps-mode-parser--table-translations)

;; 302 ((non_empty_clone_argument_list) (non_empty_clone_argument_list "," argument))
(puthash
 302
 (lambda(args _terminals)
   `(
     ast-type
     clone-arguments
     expr
     ,(append (nth 0 args) (nth 2 args))
     ))
 phps-mode-parser--table-translations)

;; 303 ((argument_no_expr) (identifier ":" expr))
(puthash
 303
 (lambda(args _terminals)
   `(
     ast-type
     named-argument
     name
     ,(nth 0 args)
     value
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 304 ((argument_no_expr) (T_ELLIPSIS expr))
(puthash
 304
 (lambda(args _terminals)
   `(
     ast-type
     ellipsis-argument
     value
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 305 ((argument) (expr))
(puthash
 305
 (lambda(args _terminals)
   `(
     ast-type
     argument-expr
     expr
     ,args
     )
   )
 phps-mode-parser--table-translations)

;; 306 ((argument) (argument_no_expr))
(puthash
 306
 (lambda(args _terminals)
   `(
     ast-type
     argument-no-expr
     value
     ,args
     )
   )
 phps-mode-parser--table-translations)

;; 307 ((global_var_list) (global_var_list "," global_var))
(puthash 307 (lambda(args _terminals) (append (nth 0 args) (list (nth 2 args)))) phps-mode-parser--table-translations)

;; 308 ((global_var_list) (global_var))
(puthash 308 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 309 ((global_var) (simple_variable))
(puthash 309 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 310 ((static_var_list) (static_var_list "," static_var))
(puthash 310 (lambda(args _terminals) (append (nth 0 args) (list (nth 2 args)))) phps-mode-parser--table-translations)

;; 311 ((static_var_list) (static_var))
(puthash 311 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 312 ((static_var) (T_VARIABLE))
(puthash
 312
 (lambda(args terminals)
   `(
     ast-type
     variable
     ast-name
     ,args
     ast-index
     ,(car (cdr terminals))
     ast-start
     ,(car (cdr terminals))
     ast-end
     ,(cdr (cdr terminals))))
 phps-mode-parser--table-translations)

;; 313 ((static_var) (T_VARIABLE "=" expr))
(puthash
 313
 (lambda(args terminals)
   ;; TODO Should bookkeep here
   `(
     ast-type
     variable
     ast-name
     ,(nth 0 args)
     expr
     ,(nth 2 args)
     ast-index
     ,(car (cdr (nth 0 terminals)))
     ast-start
     ,(car (cdr (nth 0 terminals)))
     ast-end
     ,(cdr (cdr (nth 0 terminals)))))
 phps-mode-parser--table-translations)

;; 314 ((class_statement_list) (class_statement_list class_statement))
(puthash
 314
 (lambda(args _terminals)
   (if (car args)
       (append (car args) (cdr args))
     (cdr args)))
 phps-mode-parser--table-translations)

;; 315 ((class_statement_list) (%empty))
(puthash 315 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 316 ((attributed_class_statement) (property_modifiers optional_type_without_static property_list ";"))
(puthash
316
 (lambda(args _terminals)
   `(
     ast-type
     property
     modifiers
     ,(nth 0 args)
     type
     ,(nth 1 args)
     subject
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 317 ((attributed_class_statement) (property_modifiers optional_type_without_static hooked_property))
(puthash
317
 (lambda(args _terminals)
   `(
     ast-type
     property
     modifiers
     ,(nth 0 args)
     type
     ,(nth 1 args)
     hooked-property
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 318 ((attributed_class_statement) (class_const_modifiers T_CONST class_const_list ";"))
(puthash
 318
 (lambda(args terminals)
   (when-let* ((const-list (nth 2 args)))
     (let ((const-count (length const-list))
           (const-index 0))
       (while (< const-index const-count)
         (let* ((const-item (nth const-index const-list))
                (const-item-type (plist-get const-item 'ast-type)))
           (when (equal const-item-type 'constant-assignment)
             (let ((constant-name
                    (plist-get const-item 'ast-identifier))
                   (constant-start
                    (car (cdr (nth const-index (nth 2 terminals)))))
                   (constant-end
                    (cdr (cdr (nth const-index (nth 2 terminals))))))
               (push
                (list
                 constant-name
                 phps-mode-parser-sdt--bookkeeping-namespace
                 constant-start
                 constant-end)
                phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))))
         (setq const-index (1+ const-index)))))
   `(
     ast-type
     constant
     modifiers
     ,(nth 0 args)
     subject
     ,(nth 2 args)
     ast-start
     ,(car (cdr (car (nth 2 terminals))))
     ast-end
     ,(cdr (cdr (car (nth 2 terminals))))))
 phps-mode-parser--table-translations)

;; 319 ((attributed_class_statement) (class_const_modifiers T_CONST type_expr class_const_list ";"))
(puthash
 319
 (lambda(args terminals)
   (when-let* ((const-list (nth 3 args)))
     (let ((const-count (length const-list))
           (const-index 0))
       (while (< const-index const-count)
         (let* ((const-item (nth const-index const-list))
                (const-item-type (plist-get const-item 'ast-type)))
           (when (equal const-item-type 'constant-assignment)
             (let ((constant-name
                    (plist-get const-item 'ast-identifier))
                   (constant-start
                    (car (cdr (nth const-index (nth 3 terminals)))))
                   (constant-end
                    (cdr (cdr (nth const-index (nth 3 terminals))))))
               (push
                (list
                 constant-name
                 phps-mode-parser-sdt--bookkeeping-namespace
                 constant-start
                 constant-end)
                phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))))
         (setq const-index (1+ const-index)))))
   `(
     ast-type
     constant
     modifiers
     ,(nth 0 args)
     subject
     ,(nth 3 args)
     ast-start
     ,(car (cdr (car (nth 3 terminals))))
     ast-end
     ,(cdr (cdr (car (nth 3 terminals))))))
 phps-mode-parser--table-translations)

;; 320 ((attributed_class_statement) (method_modifiers function returns_ref identifier backup_doc_comment "(" parameter_list ")" return_type backup_fn_flags method_body backup_fn_flags))
(puthash
 320
 (lambda(args terminals)
   `(
     ast-type
     method
     modifiers
     ,(nth 0 args)
     returns-reference-p
     ,(not (equal (nth 2 args) nil))
     ast-name
     ,(nth 3 args)
     parameter-list
     ,(nth 6 args)
     return-type
     ,(nth 8 args)
     method-body
     ,(if (nth 10 args)
          (nth 10 args)
        nil)
     ast-index
     ,(car (cdr (nth 3 terminals)))
     ast-start
     ,(if (listp (car (nth 10 terminals)))
          (car (cdr (car (nth 10 terminals))))
        nil)
     ast-end
     ,(if (listp (car (nth 10 terminals)))
          (cdr (cdr (car (cdr (cdr (nth 10 terminals))))))
        nil)
     nil))
 phps-mode-parser--table-translations)

;; 321 ((attributed_class_statement) (enum_case))
(puthash
 321
 (lambda(args _terminals)
   `(
     ast-type
     class-enum
     enum-case
     ,args
     )
   )
 phps-mode-parser--table-translations)

;; 322 ((class_statement) (attributed_class_statement))
(puthash
 322
 (lambda(args _terminals)
   (let* ((attributed-class-statement
           args)
          (attributed-class-statement-type
           (plist-get attributed-class-statement 'ast-type)))
     (cond

      ;; Property
      ((equal attributed-class-statement-type 'property)
       (let ((property-list
              (plist-get attributed-class-statement 'subject))
             (is-static))
         (when-let* ((property-modifiers
                      (plist-get attributed-class-statement 'modifiers)))
           (dolist (modifier property-modifiers)
             (when (equal modifier 'static)
               (setq is-static t))))
         (dolist (property property-list)
           (let ((property-type
                  (plist-get property 'ast-type)))
             (cond
              ((or
                (equal property-type 'property-variable)
                (equal property-type 'property-assigned-variable))
               (let ((symbol-name
                      (plist-get property 'variable))
                     (symbol-start
                      (plist-get property 'ast-start))
                     (symbol-end
                      (plist-get property 'ast-end))
                     (symbol-scope
                      phps-mode-parser-sdt--bookkeeping-namespace))
                 (when is-static
                   (push (list 'static) symbol-scope))
                 (push
                  (list
                   symbol-name
                   symbol-scope
                   symbol-start
                   symbol-end)
                  phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
                 (push
                  (list
                   symbol-name
                   symbol-scope
                   symbol-start
                   symbol-end)
                  phps-mode-parser-sdt--bookkeeping-symbol-stack))))))))

      ;; Method Declaration
      ((equal attributed-class-statement-type 'method)
       ;; Go through stacks and modify symbol namespaces
       ;; - add function scope but only for:
       ;;     - non-super-global variables
       ;;     - symbols defined inside function limits
       (let* ((function-name
              (plist-get
               attributed-class-statement
               'ast-name))
              (function-name-downcased
               (downcase function-name))
             (function-start
              (plist-get
               attributed-class-statement
               'ast-start))
             (function-index
              (plist-get
               attributed-class-statement
               'ast-index))
             (function-end
              (plist-get
               attributed-class-statement
               'ast-end))
             (function-parameter-list
              (plist-get
               attributed-class-statement
               'parameter-list))
             (is-static-p)
             (is-contructor-p
              (string=
               function-name-downcased
               "__construct")))

         ;; Is static method?
         (when-let* ((method-modifiers
                    (plist-get
                     attributed-class-statement
                     'modifiers)))
           (dolist (method-modifier method-modifiers)
             (when (equal method-modifier 'static)
               (setq is-static-p t))))

         ;; Add function to imenu stack
         (cond
          ((and function-start function-end)
           (if phps-mode-parser-sdt-symbol-imenu--stack
               (push
                (list (list 'function function-name function-index function-end))
                phps-mode-parser-sdt-symbol-imenu--stack)
             (setq
              phps-mode-parser-sdt-symbol-imenu--stack
              (list (list (list 'function function-name function-index function-end))))))
          (function-index
           (if phps-mode-parser-sdt-symbol-imenu--stack
               (push
                (list (list 'function function-name function-index))
                phps-mode-parser-sdt-symbol-imenu--stack)
             (setq
              phps-mode-parser-sdt-symbol-imenu--stack
              (list (list (list 'function function-name function-index)))))))

         (when (and function-start function-end)

           ;; Add $this symbol in scope unless method is static
           (unless is-static-p
             (push
              (list
               "$this"
               phps-mode-parser-sdt--bookkeeping-namespace
               (plist-get attributed-class-statement 'ast-start)
               (plist-get attributed-class-statement 'ast-end))
              phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))

           ;; Add function scope to symbol assignments
           (when phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack
             (dolist (
                      symbol-list
                      phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
               (let ((symbol-name (car symbol-list))
                     (symbol-start (nth 2 symbol-list)))
                 (unless (or
                          (gethash
                           symbol-name
                           phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
                          (< symbol-start function-start)
                          (> symbol-start function-end))
                   (let ((symbol-scope (car (cdr symbol-list))))
                     (push
                      (list 'function function-name function-start function-end)
                      symbol-scope)
                     (setcar
                      (cdr symbol-list)
                      symbol-scope))))))

           ;; Add function scope to symbol reads
           (when phps-mode-parser-sdt--bookkeeping-symbol-stack
             (dolist (
                      symbol-list
                      phps-mode-parser-sdt--bookkeeping-symbol-stack)
               (let ((symbol-name (nth 0 symbol-list))
                     (symbol-start (nth 2 symbol-list)))
                 (unless (or
                          (gethash
                           symbol-name
                           phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
                          (< symbol-start function-start)
                          (> symbol-start function-end))
                   (let ((symbol-scope (car (cdr symbol-list))))
                     (push
                      (list 'function function-name function-start function-end)
                      symbol-scope)
                     (setcar
                      (cdr symbol-list)
                      symbol-scope)))))))

         ;; Create symbol assignments out of method parameters
         (let ((symbol-scope
                phps-mode-parser-sdt--bookkeeping-namespace))
           (push
            (list 'function function-name function-start function-end)
            symbol-scope)
           (dolist (parameter function-parameter-list)
             (let ((parameter-ast-type
                    (plist-get parameter 'ast-type)))
               (cond
                ((equal parameter-ast-type 'attributed-parameter)
                 (let* ((attributed-parameter
                         (plist-get
                          parameter
                          'parameter))
                        (attributed-parameter-name
                         (plist-get attributed-parameter 'ast-name))
                        (attributed-parameter-visibility
                         (plist-get attributed-parameter 'visibility))
                        (symbol-name
                         attributed-parameter-name)
                        (symbol-start
                         (plist-get attributed-parameter 'ast-start))
                        (symbol-end
                         (plist-get attributed-parameter 'ast-end)))

                   (when (and
                          is-contructor-p
                          attributed-parameter-visibility)
                     ;; Declare class properties here
                     (push
                      (list
                       symbol-name
                       phps-mode-parser-sdt--bookkeeping-namespace
                       symbol-start
                       symbol-end)
                      phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))

                   (push
                    (list
                     symbol-name
                     symbol-scope
                     symbol-start
                     symbol-end)
                    phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
                   (push
                    (list
                     symbol-name
                     symbol-scope
                     symbol-start
                     symbol-end)
                    phps-mode-parser-sdt--bookkeeping-symbol-stack)))))))))))

   `(
     ast-type
     class-statement
     attributed-class-statement
     ,args))
 phps-mode-parser--table-translations)

;; 323 ((class_statement) (attributes attributed_class_statement))
(puthash
 323
 (lambda(args _terminals)
   (let* ((attributed-class-statement
           (nth 1 args))
          (attributed-class-statement-type
           (plist-get attributed-class-statement 'ast-type)))
     (cond
      ((equal attributed-class-statement-type 'property)
       (let ((property-list
              (plist-get attributed-class-statement 'subject)))
         (dolist (property property-list)
           (let ((property-type
                  (plist-get property 'ast-type)))
             (cond
              ((equal property-type 'property-variable)
               (let ((symbol-name
                      (plist-get property 'variable))
                     (symbol-start
                      (plist-get property 'ast-start))
                     (symbol-end
                      (plist-get property 'ast-end))
                     (symbol-scope
                      phps-mode-parser-sdt--bookkeeping-namespace))
                 (push
                  (list
                   symbol-name
                   symbol-scope
                   symbol-start
                   symbol-end)
                  phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))))))))))

   `(
     ast-type
     class-statement
     attributes
     ,(nth 0 args)
     attributed-class-statement
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 324 ((class_statement) (T_USE class_name_list trait_adaptations))
(puthash
 324
 (lambda(args _terminals)
   `(
     ast-type
     use-class-statement
     class-name-list
     ,(nth 1 args)
     trait-adaptations
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 325 ((class_name_list) (class_name))
(puthash 325 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 326 ((class_name_list) (class_name_list "," class_name))
(puthash 326 (lambda(args _terminals) (append (nth 0 args) (nth 2 args))) phps-mode-parser--table-translations)

;; 327 ((trait_adaptations) (";"))
(puthash 327 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 328 ("{" "}"))
(puthash 328 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 329 ((trait_adaptations) ("{" trait_adaptation_list "}"))
(puthash 329 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 330 ((trait_adaptation_list) (trait_adaptation))
(puthash 330 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 331 ((trait_adaptation_list) (trait_adaptation_list trait_adaptation))
(puthash 331 (lambda(args _terminals) (append (nth 0 args) (nth 1 args))) phps-mode-parser--table-translations)

;; 332 ((trait_adaptation) (trait_precedence ";"))
(puthash 332 (lambda(args _terminals) (nth 0 args)) phps-mode-parser--table-translations)

;; 333 ((trait_adaptation) (trait_alias ";"))
(puthash 333 (lambda(args _terminals) (nth 0 args)) phps-mode-parser--table-translations)

;; 334 ((trait_precedence) (absolute_trait_method_reference T_INSTEADOF class_name_list))
(puthash
 334
 (lambda(args _terminals)
   `(
     ast-type
     trait-precendence
     absolute-trait-method-reference
     ,(nth 0 args)
     instead-of
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 335 ((trait_alias) (trait_method_reference T_AS T_STRING))
(puthash
 335
 (lambda(args _terminals)
   `(
     ast-type
     trait-alias
     trait-method-reference
     ,(nth 0 args)
     as
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 336 ((trait_alias) (trait_method_reference T_AS reserved_non_modifiers))
(puthash
 336
 (lambda(args _terminals)
   `(
     ast-type
     trait-non-modifier
     trait-method-reference
     ,(nth 0 args)
     as
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 337 ((trait_alias) (trait_method_reference T_AS member_modifier identifier))
(puthash
 337
 (lambda(args _terminals)
   `(
     ast-type
     trait-alias-modifier
     trait-method-reference
     ,(nth 0 args)
     as
     ,(nth 2 args)
     identifier
     ,(nth 3 args)
     ))
 phps-mode-parser--table-translations)

;; 338 ((trait_alias) (trait_method_reference T_AS member_modifier))
(puthash
 338
 (lambda(args _terminals)
   `(
     ast-type
     trait-modifier
     trait-method-reference
     ,(nth 0 args)
     as
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 339 ((trait_method_reference) (identifier))
(puthash
 339
 (lambda(args _terminals)
   `(
     ast-type
     trait-method-reference-identifier
     identifier
     ,args))
 phps-mode-parser--table-translations)

;; 340 ((trait_method_reference) (absolute_trait_method_reference))
(puthash
 340
 (lambda(args _terminals)
   `(
     ast-type
     trait-method-reference-absolute
     absolute-trait-method-reference
     ,args)
   )
 phps-mode-parser--table-translations)

;; 341 ((absolute_trait_method_reference) (class_name T_PAAMAYIM_NEKUDOTAYIM identifier))
(puthash
 341
 (lambda(args _terminals)
   `(
     ast-type
     absolute-trait-method-reference
     class-name
     ,(nth 0 args)
     member
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 342 ((method_body) (";"))
(puthash 342 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 343 ((method_body) ("{" inner_statement_list "}"))
(puthash 343 (lambda(args _terminals) (nth 1 args)) phps-mode-parser--table-translations)

;; 344 ((property_modifiers) (non_empty_member_modifiers))
(puthash 344 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 345 ((property_modifiers) (T_VAR))
(puthash 345 (lambda(_args _terminals) '(public)) phps-mode-parser--table-translations)

;; 346 ((method_modifiers) (%empty))
(puthash 346 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 347 ((method_modifiers) (non_empty_member_modifiers))
(puthash 347 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 348 ((class_const_modifiers) (%empty))
(puthash 348 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 349 ((class_const_modifiers) (non_empty_member_modifiers))
(puthash 349 (lambda(args _terminals) args) phps-mode-parser--table-translations)

;; 350 ((non_empty_member_modifiers) (member_modifier))
(puthash 350 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 351 ((non_empty_member_modifiers) (non_empty_member_modifiers member_modifier))
(puthash 541 (lambda(args _terminals) (append (nth 0 args) (list (nth 1 args)))) phps-mode-parser--table-translations)

;; 352 ((member_modifier) (T_PUBLIC))
(puthash 352 (lambda(_args _terminals) 'public) phps-mode-parser--table-translations)

;; 353 ((member_modifier) (T_PROTECTED))
(puthash 353 (lambda(_args _terminals) 'protected) phps-mode-parser--table-translations)

;; 354 ((member_modifier) (T_PRIVATE))
(puthash 354 (lambda(_args _terminals) 'private) phps-mode-parser--table-translations)

;; 355 ((member_modifier) (T_PUBLIC_SET))
(puthash 355 (lambda(_args _terminals) 'public-set) phps-mode-parser--table-translations)

;; 356 ((member_modifier) (T_PROTECTED_SET))
(puthash 356 (lambda(_args _terminals) 'protected-set) phps-mode-parser--table-translations)

;; 357 ((member_modifier) (T_PRIVATE_SET))
(puthash 357 (lambda(_args _terminals) 'private-set) phps-mode-parser--table-translations)

;; 358 ((member_modifier) (T_STATIC))
(puthash 358 (lambda(_args _terminals) 'static) phps-mode-parser--table-translations)

;; 359 ((member_modifier) (T_ABSTRACT))
(puthash 359 (lambda(_args _terminals) 'abstract) phps-mode-parser--table-translations)

;; 360 ((member_modifier) (T_FINAL))
(puthash 360 (lambda(_args _terminals) 'final) phps-mode-parser--table-translations)

;; 361 ((member_modifier) (T_READONLY))
(puthash 361 (lambda(_args _terminals) 'readonly) phps-mode-parser--table-translations)

;; 362 ((property_list) (property_list "," property))
(puthash 362 (lambda(args _terminals) (append (nth 0 args) (list (nth 2 args)))) phps-mode-parser--table-translations)

;; 363 ((property_list) (property))
(puthash 363 (lambda(args _terminals) (list args)) phps-mode-parser--table-translations)

;; 364 ((property) (T_VARIABLE backup_doc_comment))
(puthash
 364
 (lambda(args terminals)
   `(
     ast-type
     property-variable
     ast-start
     ,(car (cdr (car terminals)))
     ast-index
     ,(car (cdr (car terminals)))
     ast-end
     ,(cdr (cdr (car terminals)))
     variable
     ,(nth 0 args)
     backup-doc-comment
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 365 ((property) (T_VARIABLE "=" expr backup_doc_comment))
(puthash
 365
 (lambda(args terminals)
   `(
     ast-type
     property-assigned-variable
     variable
     ,(nth 0 args)
     expr
     ,(nth 2 args)
     backup-doc-comment
     ,(nth 3 args)
     ast-index
     ,(car (cdr (nth 0 terminals)))
     ast-start
     ,(car (cdr (nth 0 terminals)))
     ast-end
     ,(cdr (cdr (nth 0 terminals)))))
 phps-mode-parser--table-translations)

;; 366 ((hooked_property) (T_VARIABLE backup_doc_comment "{" property_hook_list "}"))
(puthash
 366
 (lambda(args _terminals)
   `(
     ast-type
     hooked-property
     variable
     ,(nth 0 args)
     property-hook-list
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 367 ((hooked_property) (T_VARIABLE "=" expr backup_doc_comment "{" property_hook_list "}"))
(puthash
 367
 (lambda(args _terminals)
   `(
     ast-type
     hooked-property
     variable
     ,(nth 0 args)
     expr
     ,(nth 2 args)
     property-hook-list
     ,(nth 5 args)))
 phps-mode-parser--table-translations)

;; 368 ((property_hook_list) (%empty))
(puthash 368 (lambda(_args _terminals) nil) phps-mode-parser--table-translations)

;; 369 ((property_hook_list) (property_hook_list property_hook))
(puthash
 369
 (lambda(args _terminals)
   (append (nth args 0) (list (nth args 1))))
 phps-mode-parser--table-translations)

;; 370 ((property_hook_list) (property_hook_list attributes property_hook))
(puthash
 370
 (lambda(args _terminals)
   (append (nth args 0) (list (nth args 2))))
 phps-mode-parser--table-translations)

;; 371 ((optional_property_hook_list) (%empty))

;; 372 ((optional_property_hook_list) ("{" property_hook_list "}"))
(puthash
 372
 (lambda(args _terminals)
   `(
     ast-type
     property-hook-list
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 373 ((property_hook_modifiers) (%empty))

;; 374 ((property_hook_modifiers) (non_empty_member_modifiers))

;; 375 ((property_hook) (property_hook_modifiers returns_ref T_STRING backup_doc_comment optional_parameter_list backup_fn_flags property_hook_body backup_fn_flags))

;; 376 ((property_hook_body) (";"))

;; 377 ((property_hook_body) ("{" inner_statement_list "}"))

;; 378 ((property_hook_body) (T_DOUBLE_ARROW expr ";"))

;; 379 ((optional_parameter_list) (%empty))

;; 380 ((optional_parameter_list) ("(" parameter_list ")"))

;; 381 ((class_const_list) (class_const_list "," class_const_decl))
(puthash
 381
 (lambda(args _terminals)
   `(append ,(nth 1 args) ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 382 ((class_const_list) (class_const_decl))
(puthash
 382
 (lambda(args _terminals)
   (list args))
 phps-mode-parser--table-translations)

;; 383 ((class_const_decl) (T_STRING "=" expr backup_doc_comment))
(puthash
 383
 (lambda(args _terminals)
   `(
     ast-type
     constant-assignment
     ast-identifier
     ,(nth 0 args)
     ast-expr
     ,(nth 2 args)
     ast-backup-expression
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 384 ((class_const_decl) (semi_reserved "=" expr backup_doc_comment))
(puthash
 384
 (lambda(args _terminals)
   `(
     ast-type
     constant-string-assignment
     ast-string ;; TODO Not string anymore
     ,(nth 0 args)
     ast-expr
     ,(nth 2 args)
     ast-backup-expression
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 385 ((const_decl) (T_STRING "=" expr backup_doc_comment))
(puthash
 385
 (lambda(args _terminals)
   `(
     ast-type
     constant-assignment
     ast-identifier
     ,(nth 0 args)
     ast-expr
     ,(nth 2 args)
     ast-backup-expression
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 386 ((echo_expr_list) (echo_expr_list "," echo_expr))
(puthash
 386
 (lambda(args _terminals)
   `(
     ast-type
     echo-expr-list
     ast-echo-expr-list
     ,(nth 0 args)
     ast-echo-expr
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 387 ((echo_expr_list) (echo_expr))
(puthash
 387
 (lambda(args _terminals)
   `(
     ast-type
     echo-expr-list
     ast-echo-expr
     ,args))
 phps-mode-parser--table-translations)

;; 388 ((echo_expr) (expr))
(puthash
 388
 (lambda(args _terminals)
   `(
     ast-type
     echo-expr
     ast-expr
     ,args))
 phps-mode-parser--table-translations)

;; 389 ((for_cond_exprs) (%empty))
(puthash
 389
 (lambda(_args _terminals)
   `(
     ast-type
     empty-for-cond-exprs))
 phps-mode-parser--table-translations)

;; 390 ((for_cond_exprs) (non_empty_for_exprs "," expr))
(puthash
 390
 (lambda(args _terminals)
   `(
     ast-type
     non-empty-for-cond-exprs
     for-expr
     ,(nth 0 args)
     expr
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 391 ((for_cond_exprs) (expr))
(puthash
 391
 (lambda(args _terminals)
   `(
     ast-type
     for-cond-exprs
     expr
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 392 ((for_exprs) (%empty))
(puthash
 392
 (lambda(_args _terminals)
   `(
     ast-type
     empty-for-exprs))
 phps-mode-parser--table-translations)

;; 393 ((for_exprs) (non_empty_for_exprs))
(puthash
 393
 (lambda(args _terminals)
   `(
     ast-type
     non-empty-for-exprs
     ast-for-expr
     ,args
     ))
 phps-mode-parser--table-translations)

;; 394 ((non_empty_for_exprs) (non_empty_for_exprs "," expr))
(puthash
 394
 (lambda(args _terminals)
   `(
     ast-type
     non-empty-for-exprs
     ast-for-expr
     ,(nth 0 args)
     ast-expr
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 395 ((non_empty_for_exprs) (non_empty_for_exprs "," T_VOID_CAST expr))
(puthash
 395
 (lambda(args _terminals)
   `(
     ast-type
     non-empty-for-exprs
     ast-for-expr
     ,(nth 0 args)
     ast-expr-void-cast
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 396 ((non_empty_for_exprs) (T_VOID_CAST expr))
(puthash
 396
 (lambda(args _terminals)
   `(
     ast-type
     non-empty-for-exprs
     ast-expr-void-cast
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 397 ((non_empty_for_exprs) (expr))
(puthash
 397
 (lambda(args _terminals)
   `(
     ast-type
     non-empty-for-exprs
     ast-expr
     ,args
     ))
 phps-mode-parser--table-translations)

;; 398 ((anonymous_class) (T_CLASS ctor_arguments extends_from implements_list backup_doc_comment "{" class_statement_list "}"))
(puthash
 398
 (lambda(args _terminals)
   `(
     ast-type
     anonymous-class
     ctor-arguments
     ,(nth 1 args)
     extends-from
     ,(nth 2 args)
     implements-list
     ,(nth 3 args)
     backup-doc-comment
     ,(nth 4 args)
     class-statement-list
     ,(nth 6 args)
     ))
 phps-mode-parser--table-translations)

;; 399 ((new_dereferenceable) (T_NEW class_name_reference argument_list))
(puthash
 399
 (lambda(args _terminals)
   `(
     ast-type
     new-dereferenceable
     class-name-reference
     ,(nth 1 args)
     argument-list
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 400 ((new_dereferenceable) (T_NEW anonymous_class))
(puthash
 400
 (lambda(args _terminals)
   `(
     ast-type
     new-dereferenceable
     anonymous-class
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 401 ((new_dereferenceable) (T_NEW attributes anonymous_class))
(puthash
 401
 (lambda(args _terminals)
   `(
     ast-type
     new-dereferenceable
     attributes
     ,(nth 1 args)
     anonymous-class
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 402 ((new_non_dereferenceable) (T_NEW class_name_reference))
(puthash
 402
 (lambda(args _terminals)
   `(
     ast-type
     new-non-dereferenceable
     class-name-reference
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 403 ((expr) (variable))
(puthash
 403
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable
     variable
     ,args))
 phps-mode-parser--table-translations)

;; 404 ((expr) (T_LIST "(" array_pair_list ")" "=" expr))
(puthash
 404
 (lambda(args _terminals)
   (let ((array-pair-list (nth 2 args)))
     (dolist (array-item array-pair-list)
       (let ((array-item-type (plist-get array-item 'ast-type)))
         (cond
          ((equal array-item-type 'array-pair-expr)
           (let* ((array-item-expr (plist-get array-item 'expr))
                  (array-item-expr-type (plist-get array-item-expr 'ast-type)))
             (cond
              ((equal array-item-expr-type 'expr-variable)
               (let* ((expr-variable (plist-get array-item-expr 'variable))
                      (expr-variable-type (plist-get expr-variable 'ast-type)))
                 (cond
                  ((equal expr-variable-type 'variable-callable-variable)
                   (let* ((callable-variable (plist-get expr-variable 'callable-variable))
                          (callable-variable-type (plist-get callable-variable 'ast-type)))
                     (cond
                      ((equal callable-variable-type 'callable-variable-simple-variable)
                       (let* ((callable-simple-variable
                               (plist-get callable-variable 'simple-variable))
                              (variable-name
                               (plist-get callable-simple-variable 'variable))
                              (variable-start
                               (plist-get callable-simple-variable 'ast-start))
                              (variable-end
                               (plist-get callable-simple-variable 'ast-end)))
                         (push
                          (list
                           variable-name
                           phps-mode-parser-sdt--bookkeeping-namespace
                           variable-start
                           variable-end)
                          phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))))))))))))))))
   `(
     ast-type
     expr-list
     ,(nth 2 args)
     expr
     ,(nth 4 args)
     ))
 phps-mode-parser--table-translations)

;; 405 ((expr) ("[" array_pair_list "]" "=" expr))
(puthash
 405
 (lambda(args _terminals)
   (let ((array-pair-list (nth 1 args)))
     (dolist (array-item array-pair-list)
       (let ((array-item-type (plist-get array-item 'ast-type)))
         (cond
          ((equal array-item-type 'array-pair-expr)
           (let* ((array-item-expr (plist-get array-item 'expr))
                  (array-item-expr-type (plist-get array-item-expr 'ast-type)))
             (cond
              ((equal array-item-expr-type 'expr-variable)
               (let* ((expr-variable (plist-get array-item-expr 'variable))
                      (expr-variable-type (plist-get expr-variable 'ast-type)))
                 (cond
                  ((equal expr-variable-type 'variable-callable-variable)
                   (let* ((callable-variable (plist-get expr-variable 'callable-variable))
                          (callable-variable-type (plist-get callable-variable 'ast-type)))
                     (cond
                      ((equal callable-variable-type 'callable-variable-simple-variable)
                       (let* ((callable-simple-variable
                               (plist-get callable-variable 'simple-variable))
                              (variable-name
                               (plist-get callable-simple-variable 'variable))
                              (variable-start
                               (plist-get callable-simple-variable 'ast-start))
                              (variable-end
                               (plist-get callable-simple-variable 'ast-end)))
                         (push
                          (list
                           variable-name
                           phps-mode-parser-sdt--bookkeeping-namespace
                           variable-start
                           variable-end)
                          phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))))))))))))))))
   `(
     ast-type
     expr-list
     array-pair-list
     ,(nth 1 args)
     expr
     ,(nth 4 args)
     ))
 phps-mode-parser--table-translations)

;; 406 ((expr) (variable "=" expr))
(puthash
 406
 (lambda(args terminals)
   ;; Save variable declaration in bookkeeping buffer
   (let ((variable-type (plist-get (nth 0 args) 'ast-type)))
     (cond
      ((equal variable-type 'variable-callable-variable)
       (let* ((callable-variable (plist-get (nth 0 args) 'callable-variable))
              (callable-variable-type (plist-get callable-variable 'ast-type)))
         (cond
          ((equal callable-variable-type 'callable-variable-simple-variable)
           (let ((callable-variable-simple-variable (plist-get callable-variable 'simple-variable)))
             (let ((callable-variable-simple-variable-type
                    (plist-get
                     callable-variable-simple-variable
                     'ast-type)))
               (cond
                ((equal
                  callable-variable-simple-variable-type
                  'simple-variable-variable)
                 (let* ((variable-name
                         (plist-get
                          callable-variable-simple-variable
                          'variable))
                        (symbol-name
                          variable-name)
                        (symbol-start
                         (car (cdr (car terminals))))
                        (symbol-end
                         (cdr (cdr (car terminals))))
                        (symbol-scope
                         phps-mode-parser-sdt--bookkeeping-namespace))

                   ;; (message "declared variable from terminals: %S" terminals)
                   (push
                    (list
                     symbol-name
                     symbol-scope
                     symbol-start
                     symbol-end)
                    phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))))))))))))

   `(
     ast-type
     expr-assign-variable-by-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 2 args)
     ast-index
     ,(car (cdr (nth 0 terminals)))
     ast-start
     ,(car (cdr (nth 0 terminals)))
     ast-end
     ,(cdr (cdr (nth 0 terminals)))))
 phps-mode-parser--table-translations)

;; 407 ((expr) (variable "=" ampersand variable))
(puthash
 407
 (lambda(args terminals)
   ;; Save variable declaration in bookkeeping buffer
   (let ((variable-type1 (plist-get (nth 0 args) 'ast-type)))
     (cond
      ((equal variable-type1 'variable-callable-variable)
       (let* ((callable-variable1 (plist-get (nth 0 args) 'callable-variable))
              (callable-variable-type1 (plist-get callable-variable1 'ast-type)))
         (cond
          ((equal callable-variable-type1 'callable-variable-simple-variable)
           (let* ((callable-variable-simple-variable1
                   (plist-get callable-variable1 'simple-variable))
                  (callable-variable-simple-variable-type1
                   (plist-get
                    callable-variable-simple-variable1
                    'ast-type)))
             (cond
              ((equal
                callable-variable-simple-variable-type1
                'simple-variable-variable)
               (let* ((variable-name1
                       (plist-get
                        callable-variable-simple-variable1
                        'variable))
                      (symbol-name1
                       variable-name1)
                      (symbol-start
                       (car (cdr (car terminals))))
                      (symbol-end
                       (cdr (cdr (car terminals))))
                      (symbol-scope
                       phps-mode-parser-sdt--bookkeeping-namespace))
                 (push
                  (list
                   symbol-name1
                   symbol-scope
                   symbol-start
                   symbol-end)
                  phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)))))))))))

   `(
     ast-type
     expr-assign-variable-by-reference
     variable
     ,(nth 0 args)
     reference
     ,(nth 2 args)
     ast-index
     ,(car (cdr (nth 0 terminals)))
     ast-start
     ,(car (cdr (nth 0 terminals)))
     ast-end
     ,(cdr (cdr (nth 0 terminals)))
     ))
 phps-mode-parser--table-translations)

;; 408 ((expr) (T_CLONE clone_argument_list))
(puthash
 408
 (lambda(args _terminals)
   `(
     ast-type
     expr-clone
     clone-argument-list
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 409 ((expr) (T_CLONE expr))
(puthash
 409
 (lambda(args _terminals)
   `(
     ast-type
     expr-clone
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 410 ((expr) (variable T_PLUS_EQUAL expr))
(puthash
 410
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-plus-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 411 ((expr) (variable T_MINUS_EQUAL expr))
(puthash
 411
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-minus-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 412 ((expr) (variable T_MUL_EQUAL expr))
(puthash
 412
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-mul-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 413 ((expr) (variable T_POW_EQUAL expr))
(puthash
 413
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-pow-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 414 ((expr) (variable T_DIV_EQUAL expr))
(puthash
 414
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-div-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 415 ((expr) (variable T_CONCAT_EQUAL expr))
(puthash
 415
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-concat-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 416 ((expr) (variable T_MOD_EQUAL expr))
(puthash
 416
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-mod-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 417 ((expr) (variable T_AND_EQUAL expr))
(puthash
 417
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-and-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 418 ((expr) (variable T_OR_EQUAL expr))
(puthash
 418
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-or-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 419 ((expr) (variable T_XOR_EQUAL expr))
(puthash
 419
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-xor-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 420 ((expr) (variable T_SL_EQUAL expr))
(puthash
 420
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-sl-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 421 ((expr) (variable T_SR_EQUAL expr))
(puthash
 421
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-sr-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 422 ((expr) (variable T_COALESCE_EQUAL expr))
(puthash
 422
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-coalesce-equal-expr
     variable
     ,(nth 0 args)
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 423 ((expr) (variable T_INC))
(puthash
 423
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-inc
     variable
     ,(nth 0 args)
     ))
 phps-mode-parser--table-translations)

;; 424 ((expr) (T_INC variable))
(puthash
 424
 (lambda(args _terminals)
   `(
     ast-type
     expr-inc-variable
     variable
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 425 ((expr) (variable T_DEC))
(puthash
 425
 (lambda(args _terminals)
   `(
     ast-type
     expr-variable-dec
     variable
     ,(nth 0 args)
     ))
 phps-mode-parser--table-translations)

;; 426 ((expr) (T_DEC variable))
(puthash
 426
 (lambda(args _terminals)
   `(
     ast-type
     expr-dev-variable
     variable
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 427 ((expr) (expr T_BOOLEAN_OR expr))
(puthash
 427
 (lambda(args _terminals)
   `(
     ast-type
     expr-boolean-or-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 428 ((expr) (expr T_BOOLEAN_AND expr))
(puthash
 428
 (lambda(args _terminals)
   `(
     ast-type
     expr-boolean-and-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 429 ((expr) (expr T_LOGICAL_OR expr))
(puthash
 429
 (lambda(args _terminals)
   `(
     ast-type
     expr-logical-or-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 430 ((expr) (expr T_LOGICAL_AND expr))
(puthash
 430
 (lambda(args _terminals)
   `(
     ast-type
     expr-logical-and-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 431 ((expr) (expr T_LOGICAL_XOR expr))
(puthash
 431
 (lambda(args _terminals)
   `(
     ast-type
     expr-logical-xor-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 432 ((expr) (expr "|" expr))
(puthash
 432
 (lambda(args _terminals)
   `(
     ast-type
     expr-bitwise-or-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 433 ((expr) (expr T_AMPERSAND_NOT_FOLLOWED_BY_VAR_OR_VARARG expr))
(puthash
 433
 (lambda(args _terminals)
   `(
     ast-type
     expr-bitwise-and-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 434 ((expr) (expr T_AMPERSAND_FOLLOWED_BY_VAR_OR_VARARG expr))
(puthash
 434
 (lambda(args _terminals)
   `(
     ast-type
     expr-bitwise-and-variable
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 435 ((expr) (expr "^" expr))
(puthash
 435
 (lambda(args _terminals)
   `(
     ast-type
     expr-bitwise-xor-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 436 ((expr) (expr "." expr))
(puthash
 436
 (lambda(args _terminals)
   `(
     ast-type
     expr-string-concatenation-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 437 ((expr) (expr "+" expr))
(puthash
 437
 (lambda(args _terminals)
   `(
     ast-type
     expr-arithmetic-addition-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 438 ((expr) (expr "-" expr))
(puthash
 438
 (lambda(args _terminals)
   `(
     ast-type
     expr-arithmetic-substraction-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 439 ((expr) (expr "*" expr))
(puthash
 439
 (lambda(args _terminals)
   `(
     ast-type
     expr-arithmetic-multiplication-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 440 ((expr) (expr T_POW expr))
(puthash
 440
 (lambda(args _terminals)
   `(
     ast-type
     expr-arithmetic-exponentiation-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 441 ((expr) (expr "/" expr))
(puthash
 441
 (lambda(args _terminals)
   `(
     ast-type
     expr-arithmetic-division-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 442 ((expr) (expr "%" expr))
(puthash
 442
 (lambda(args _terminals)
   `(
     ast-type
     expr-arithmetic-modulo-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 443 ((expr) (expr T_SL expr))
(puthash
 443
 (lambda(args _terminals)
   `(
     ast-type
     expr-bitwise-shift-left-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 444 ((expr) (expr T_SR expr))
(puthash
 444
 (lambda(args _terminals)
   `(
     ast-type
     expr-bitwise-shift-right-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 445 ((expr) ("+" expr))
(puthash
 445
 (lambda(args _terminals)
   `(
     ast-type
     expr-arithmetic-addition
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 446 ((expr) ("-" expr))
(puthash
 446
 (lambda(args _terminals)
   `(
     ast-type
     expr-arithmetic-subtraction
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 447 ((expr) ("!" expr))
(puthash
 447
 (lambda(args _terminals)
   `(
     ast-type
     expr-logical-not
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 448 ((expr) ("~" expr))
(puthash
 448
 (lambda(args _terminals)
   `(
     ast-type
     expr-bitwise-not
     expr
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 449 ((expr) (expr T_IS_IDENTICAL expr))
(puthash
 449
 (lambda(args _terminals)
   `(
     ast-type
     expr-is-identical-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 450 ((expr) (expr T_IS_NOT_IDENTICAL expr))
(puthash
 450
 (lambda(args _terminals)
   `(
     ast-type
     expr-is-not-identical-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 451 ((expr) (expr T_IS_EQUAL expr))
(puthash
 451
 (lambda(args _terminals)
   `(
     ast-type
     expr-comparison-is-equal-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 452 ((expr) (expr T_IS_NOT_EQUAL expr))
(puthash
 452
 (lambda(args _terminals)
   `(
     ast-type
     expr-comparison-is-not-equal-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 453 ((expr) (expr T_PIPE expr))
(puthash
 453
 (lambda(args _terminals)
   `(
     ast-type
     expr-pipe-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 454 ((expr) (expr "<" expr))
(puthash
 454
 (lambda(args _terminals)
   `(
     ast-type
     expr-comparison-is-less-than-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 455 ((expr) (expr T_IS_SMALLER_OR_EQUAL expr))
(puthash
 455
 (lambda(args _terminals)
   `(
     ast-type
     expr-comparison-is-less-or-equal-than-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 456 ((expr) (expr ">" expr))
(puthash
 456
 (lambda(args _terminals)
   `(
     ast-type
     expr-comparison-is-greater-than-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 457 ((expr) (expr T_IS_GREATER_OR_EQUAL expr))
(puthash
 457
 (lambda(args _terminals)
   `(
     ast-type
     expr-comparison-is-greater-or-equal-than-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 458 ((expr) (expr T_SPACESHIP expr))
(puthash
 458
 (lambda(args _terminals)
   `(
     ast-type
     expr-comparison-spaceship-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 459 ((expr) (expr T_INSTANCEOF class_name_reference))
(puthash
 459
 (lambda(args _terminals)
   `(
     ast-type
     expr-type-instance-of
     expr-1
     ,(nth 0 args)
     class-name-reference
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 460 ((expr) ("(" expr ")"))
(puthash
 460
 (lambda(args _terminals)
   (nth 1 args))
 phps-mode-parser--table-translations)

;; 461 ((expr) (new_dereferenceable))
(puthash
 461
 (lambda(args _terminals)
   `(
     ast-type
     expr-new-dereferenceable
     expr
     ,args))
 phps-mode-parser--table-translations)

;; 462 ((expr) (new_non_dereferenceable))
(puthash
 462
 (lambda(args _terminals)
   `(
     ast-type
     expr-new-non-dereferenceable
     expr
     ,args))
 phps-mode-parser--table-translations)

;; 463 ((expr) (expr "?" expr ":" expr))
(puthash
 463
 (lambda(args _terminals)
   `(
     ast-type
     expr-ternary-expr
     expr-test
     ,(nth 0 args)
     expr-true
     ,(nth 2 args)
     expr-false
     ,(nth 4 args)))
 phps-mode-parser--table-translations)

;; 464 ((expr) (expr "?" ":" expr))
(puthash
 464
 (lambda(args _terminals)
   `(
     ast-type
     expr-ternary-expr
     expr-test
     ,(nth 0 args)
     expr-true
     ,(nth 0 args)
     expr-false
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 465 ((expr) (expr T_COALESCE expr))
(puthash
 465
 (lambda(args _terminals)
   `(
     ast-type
     expr-coalesce-expr
     expr-1
     ,(nth 0 args)
     expr-2
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 466 ((expr) (internal_functions_in_yacc))
(puthash
 449
 (lambda(args _terminals)
   `(
     ast-type
     expr-internal-functions-in-yacc
     expr-internal-functions-in-yacc
     ,args))
 phps-mode-parser--table-translations)

;; 467 ((expr) (T_INT_CAST expr))
(puthash
 467
 (lambda(args _terminals)
   `(
     ast-type
     expr-cast-int
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 468 ((expr) (T_DOUBLE_CAST expr))
(puthash
 468
 (lambda(args _terminals)
   `(
     ast-type
     expr-cast-double
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 469 ((expr) (T_STRING_CAST expr))
(puthash
 469
 (lambda(args _terminals)
   `(
     ast-type
     expr-cast-string
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 470 ((expr) (T_ARRAY_CAST expr))
(puthash
 470
 (lambda(args _terminals)
   `(
     ast-type
     expr-cast-array
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 471 ((expr) (T_OBJECT_CAST expr))
(puthash
 471
 (lambda(args _terminals)
   `(
     ast-type
     expr-cast-object
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 472 ((expr) (T_BOOL_CAST expr))
(puthash
 472
 (lambda(args _terminals)
   `(
     ast-type
     expr-cast-bool
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 473 ((expr) (T_UNSET_CAST expr))
(puthash
 473
 (lambda(args _terminals)
   `(
     ast-type
     expr-cast-unset
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 474 ((expr) (T_EXIT ctor_arguments))
(puthash
 474
 (lambda(args _terminals)
   `(
     ast-type
     expr-exit
     ctor_arguments
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 475 ((expr) ("@" expr))
(puthash
 475
 (lambda(args _terminals)
   `(
     ast-type
     expr-error-suppress
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 476 ((expr) (scalar))
(puthash
 476
 (lambda(args _terminals)
   `(
     ast-type
     expr-scalar
     scalar
     ,args))
 phps-mode-parser--table-translations)

;; 477 ((expr) ("`" backticks_expr "`"))
(puthash
 477
 (lambda(args _terminals)
   `(
     ast-type
     expr-backticks-expr
     backticks-expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 478 ((expr) (T_PRINT expr))
(puthash
 478
 (lambda(args _terminals)
   `(
     ast-type
     expr-print-expr
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 479 ((expr) (T_YIELD))
(puthash
 479
 (lambda(_args _terminals)
   `(
     ast-type
     expr-yield))
 phps-mode-parser--table-translations)

;; 480 ((expr) (T_YIELD expr))
(puthash
 480
 (lambda(args _terminals)
   `(
     ast-type
     expr-yield-expr
     expr
     ,args))
 phps-mode-parser--table-translations)

;; 481 ((expr) (T_YIELD expr T_DOUBLE_ARROW expr))
(puthash
 481
 (lambda(args _terminals)
   `(
     ast-type
     expr-yield-expr-key-value
     expr-key
     ,(nth 1 args)
     expr-value
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 482 ((expr) (T_YIELD_FROM expr))
(puthash
 482
 (lambda(args _terminals)
   `(
     ast-type
     expr-yield-from-expr
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 483 ((expr) (T_THROW expr))
(puthash
 483
 (lambda(args _terminals)
   `(
     ast-type
     expr-throw-expr
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 484 ((expr) (inline_function))
(puthash
 467
 (lambda(args _terminals)
   `(
     ast-type
     expr-inline-function
     inline-function
     ,args))
 phps-mode-parser--table-translations)

;; 485 ((expr) (attributes inline_function))
(puthash
 485
 (lambda(args _terminals)
   `(
     ast-type
     expr-attributed-inline-function
     attributes
     ,(nth 0 args)
     inline-function
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 486 ((expr) (T_STATIC inline_function))
(puthash
 486
 (lambda(args _terminals)
   `(
     ast-type
     expr-static-inline-function
     inline-function
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 487 ((expr) (attributes T_STATIC inline_function))
(puthash
 487
 (lambda(args _terminals)
   `(
     ast-type
     expr-attributed-static-inline-function
     attributes
     ,(nth 0 args)
     inline-function
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 488 ((expr) (match))
(puthash
 488
 (lambda(args _terminals)
   `(
     ast-type
     expr-match
     match
     ,args))
 phps-mode-parser--table-translations)

;; 489 ((inline_function) (function returns_ref backup_doc_comment "(" parameter_list ")" lexical_vars return_type backup_fn_flags "{" inner_statement_list "}" backup_fn_flags))
(puthash
 489
 (lambda(args terminals)
   (let ((function-start
          (cdr (cdr (nth 9 terminals))))
         (function-end
          (car (cdr (nth 11 terminals))))
         (namespace
          phps-mode-parser-sdt--bookkeeping-namespace)
         (parameter-list
          (nth 4 args))
         (lexical-vars
          (nth 6 args)))
     (setq
      phps-mode-parser-sdt--bookkeeping-anonymous-function-count
      (1+ phps-mode-parser-sdt--bookkeeping-anonymous-function-count))
     (push
      (list
       'anonymous-function
       phps-mode-parser-sdt--bookkeeping-anonymous-function-count)
      namespace)

     ;; Go through parameters and assign variables inside function
     (when parameter-list
       (dolist (parameter parameter-list)
         (let ((parameter-type
                (plist-get
                 parameter
                 'ast-type)))
           (cond
            ((equal parameter-type 'attributed-parameter)
             (let* ((attributed-parameter
                     (plist-get parameter 'parameter))
                    (parameter-name
                     (plist-get attributed-parameter 'ast-name))
                    (parameter-start
                     (plist-get attributed-parameter 'ast-start))
                    (parameter-end
                     (plist-get attributed-parameter 'ast-end)))
               (push
                (list
                 parameter-name
                 namespace
                 parameter-start
                 parameter-end)
                phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
               (push
                (list
                 parameter-name
                 namespace
                 parameter-start
                 parameter-end)
                phps-mode-parser-sdt--bookkeeping-symbol-stack)))))))

     ;; Go through lexical_vars and assign inside function
     (when lexical-vars
       (let ((lexical-vars-type
              (plist-get lexical-vars 'ast-type)))
         (cond
          ((equal lexical-vars-type 'lexical-vars)
           (let ((lexical-var-list
                  (plist-get lexical-vars 'lexical-var-list)))
             (dolist (lexical-var lexical-var-list)
               (let ((lexical-var-type
                      (plist-get lexical-var 'ast-type)))
                 (cond
                  ((equal lexical-var-type 'lexical-var-variable)
                   (let ((lexical-var-name
                          (plist-get lexical-var 'ast-name))
                         (lexical-var-start
                          (plist-get lexical-var 'ast-start))
                         (lexical-var-end
                          (plist-get lexical-var 'ast-end)))
                     (push
                      (list
                       lexical-var-name
                       namespace
                       lexical-var-start
                       lexical-var-end)
                      phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
                     (push
                      (list
                       lexical-var-name
                       phps-mode-parser-sdt--bookkeeping-namespace
                       lexical-var-start
                       lexical-var-end)
                      phps-mode-parser-sdt--bookkeeping-symbol-stack)))))))))))

     ;; Go through phps-mode-parser-sdt--bookkeeping-symbol-stack in scope and add namespace
     (when (and
            phps-mode-parser-sdt--bookkeeping-symbol-stack
            function-start
            function-end)
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-stack)
         (let ((symbol-name (nth 0 symbol-list))
               (symbol-start (nth 2 symbol-list)))
           (unless (or
                    (gethash
                     symbol-name
                     phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
                    (< symbol-start function-start)
                    (> symbol-start function-end))
             (let ((symbol-scope (car (cdr symbol-list))))
               (push
                (list
                 'anonymous-function
                 phps-mode-parser-sdt--bookkeeping-anonymous-function-count)
                symbol-scope)
               (setcar
                (cdr symbol-list)
                symbol-scope)))))))

   `(
     ast-type
     inline-function
     function
     ,(nth 0 args)
     returns-ref
     ,(nth 1 args)
     backup-doc-comment
     ,(nth 2 args)
     parameter-list
     ,(nth 4 args)
     lexical-vars
     ,(nth 6 args)
     return-type
     ,(nth 7 args)
     backup-fn-flags-pre
     ,(nth 8 args)
     inner-statement-list
     ,(nth 10 args)
     backup-fn-flags-post
     ,(nth 12 args)))
 phps-mode-parser--table-translations)

;; 490 ((inline_function) (fn returns_ref backup_doc_comment "(" parameter_list ")" return_type T_DOUBLE_ARROW backup_fn_flags backup_lex_pos expr backup_fn_flags))
(puthash
 490
 (lambda(args _terminals)
   (let ((namespace
          phps-mode-parser-sdt--bookkeeping-namespace)
         (parameter-list
          (nth 4 args)))
     (setq
      phps-mode-parser-sdt--bookkeeping-arrow-function-count
      (1+ phps-mode-parser-sdt--bookkeeping-arrow-function-count))
     (push
      (list
       'arrow-function
       phps-mode-parser-sdt--bookkeeping-arrow-function-count)
      namespace)

     ;; Go through symbol stack in scope and add namespace
     (when phps-mode-parser-sdt--bookkeeping-symbol-stack
       (dolist (
                symbol-list
                phps-mode-parser-sdt--bookkeeping-symbol-stack)
         (let ((symbol-name (nth 0 symbol-list)))
           (unless (gethash
                    symbol-name
                    phps-mode-parser-sdt--bookkeeping--superglobal-variable-p)
             (let ((symbol-scope (car (cdr symbol-list))))
               (push
                (list
                 'arrow-function
                 phps-mode-parser-sdt--bookkeeping-arrow-function-count)
                symbol-scope)
               (setcar
                (cdr symbol-list)
                symbol-scope))))))

     ;; Go through parameters and assign variables inside function
     (when parameter-list
       (dolist (parameter parameter-list)
         (let ((parameter-type
                (plist-get
                 parameter
                 'ast-type)))
           (cond
            ((equal parameter-type 'attributed-parameter)
             (let* ((attributed-parameter
                     (plist-get parameter 'parameter))
                    (parameter-name
                     (plist-get attributed-parameter 'ast-name))
                    (parameter-start
                     (plist-get attributed-parameter 'ast-start))
                    (parameter-end
                     (plist-get attributed-parameter 'ast-end)))
               (push
                (list
                 parameter-name
                 namespace
                 parameter-start
                 parameter-end)
                phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack)
               (push
                (list
                 parameter-name
                 namespace
                 parameter-start
                 parameter-end)
                phps-mode-parser-sdt--bookkeeping-symbol-stack))))))))
   `(
     ast-type
     inline-fn
     returns-ref
     ,(nth 1 args)
     backup-doc-comment
     ,(nth 2 args)
     parameter-list
     ,(nth 4 args)
     return-type
     ,(nth 6 args)
     backup-fn-flags-pre
     ,(nth 8 args)
     backup-lex-pos
     ,(nth 9 args)
     expr
     ,(nth 10 args)
     backup-fn-flags-post
     ,(nth 11 args)))
 phps-mode-parser--table-translations)

;; 491 ((fn) (T_FN))
(puthash
 491
 (lambda(_args _terminals)
   `(
     ast-type
     fn))
 phps-mode-parser--table-translations)

;; 492 ((function) (T_FUNCTION))
(puthash
 492
 (lambda(_args _terminals)
   `(
     ast-type
     function))
 phps-mode-parser--table-translations)

;; 493 ((backup_doc_comment) (%empty))
(puthash
 493
 (lambda(_args _terminals) nil)
 phps-mode-parser--table-translations)

;; 494 ((backup_fn_flags) (%empty))
(puthash
 494
 (lambda(_args _terminals) nil)
 phps-mode-parser--table-translations)

;; 495 ((backup_lex_pos) (%empty))
(puthash
 495
 (lambda(_args _terminals) nil)
 phps-mode-parser--table-translations)

;; 496 ((returns_ref) (%empty))
(puthash
 496
 (lambda(_args _terminals) nil)
 phps-mode-parser--table-translations)

;; 497 ((returns_ref) (ampersand))
(puthash
 497
 (lambda(_args _terminals) t)
 phps-mode-parser--table-translations)

;; 498 ((lexical_vars) (%empty))
(puthash
 498
 (lambda(_args _terminals) nil)
 phps-mode-parser--table-translations)

;; 499 ((lexical_vars) (T_USE "(" lexical_var_list possible_comma ")"))
(puthash
 499
 (lambda(args _terminals)
   `(
     ast-type
     lexical-vars
     lexical-var-list
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 500 ((lexical_var_list) (lexical_var_list "," lexical_var))
(puthash
 500
 (lambda(args _terminals)
   (append (nth 0 args) (nth 2 args)))
 phps-mode-parser--table-translations)

;; 501 ((lexical_var_list) (lexical_var))
(puthash
 501
 (lambda(args _terminals)
   (list args))
 phps-mode-parser--table-translations)

;; 502 ((lexical_var) (T_VARIABLE))
(puthash
 502
 (lambda(args terminals)
   `(
     ast-type
     lexical-var-variable
     ast-name
     ,args
     ast-start
     ,(car (cdr terminals))
     ast-end
     ,(cdr (cdr terminals))))
 phps-mode-parser--table-translations)

;; 503 ((lexical_var) (ampersand T_VARIABLE))
(puthash
 503
 (lambda(args terminals)
   `(
     ast-type
     lexical-var-reference
     ast-name
     ,(nth 1 args)
     ast-start
     ,(car (cdr (nth 1 terminals)))
     ,(cdr (cdr (nth 1 terminals)))))
 phps-mode-parser--table-translations)

;; 504 ((function_call) (name argument_list))
(puthash
 504
 (lambda(args _terminals)
   `(
     ast-type
     function-call
     name
     ,(nth 0 args)
     argument-list
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 505 ((function_call) (T_READONLY argument_list))
(puthash
 505
 (lambda(args _terminals)
   `(
     ast-type
     readonly-function-call
     argument-list
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 506 ((function_call) (class_name T_PAAMAYIM_NEKUDOTAYIM member_name argument_list))
(puthash
 506
 (lambda(args _terminals)
   `(
     ast-type
     function-call-class
     class-name
     ,(nth 0 args)
     member-name
     ,(nth 2 args)
     argument-list
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 507 ((function_call) (variable_class_name T_PAAMAYIM_NEKUDOTAYIM member_name argument_list))
(puthash
 507
 (lambda(args _terminals)
   `(
     ast-type
     function-call-variable-class
     variable-class-name
     ,(nth 0 args)
     member-name
     ,(nth 2 args)
     argument-list
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 508 ((function_call) (callable_expr argument_list))
(puthash
 508
 (lambda(args _terminals)
   `(
     ast-type
     function-call-callable-expr
     callable-expr
     ,(nth 0 args)
     argument-list
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 509((class_name) (T_STATIC))
(puthash
 509
 (lambda(_args _terminals)
   `(
     ast-type
     class-name-static))
 phps-mode-parser--table-translations)

;; 510 ((class_name) (name))
(puthash
 510
 (lambda(args _terminals)
   `(
     ast-type
     class-name-name
     name
     ,args))
 phps-mode-parser--table-translations)

;; 511 ((class_name_reference) (class_name))
(puthash
 511
 (lambda(args _terminals)
   `(
     ast-type
     class-name-reference-class-name
     class-name
     ,args))
 phps-mode-parser--table-translations)

;; 512 ((class_name_reference) (new_variable))
(puthash
 512
 (lambda(args _terminals)
   `(
     ast-type
     class-name-reference-new-variable
     new-variable
     ,args))
 phps-mode-parser--table-translations)

;; 513 ((class_name_reference) ("(" expr ")"))
(puthash
 513
 (lambda(args _terminals)
   `(
     ast-type
     class-name-reference-expr
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 514 ((backticks_expr) (%empty))
(puthash
 514
 (lambda(_args _terminals)
   `(
     ast-type
     backticks-expr-empty))
 phps-mode-parser--table-translations)

;; 515 ((backticks_expr) (T_ENCAPSED_AND_WHITESPACE))
(puthash
 515
 (lambda(args _terminals)
   `(
     ast-type
     backticks-expr-encapsed-and-whitespace
     encapsed-and-whitespace
     ,args))
 phps-mode-parser--table-translations)

;; 516 ((backticks_expr) (encaps_list))
(puthash
 516
 (lambda(args _terminals)
   `(
     ast-type
     backticks-expr-encaps-list
     encaps-list
     ,args))
 phps-mode-parser--table-translations)

;; 517 ((ctor_arguments) (%empty))
(puthash
 517
 (lambda(_args _terminals)
   `(
     ast-type
     ctor-arguments-empty))
 phps-mode-parser--table-translations)

;; 518 ((ctor_arguments) (argument_list))
(puthash
 518
 (lambda(args _terminals)
   `(
     ast-type
     ctor-arguments-argument-list
     argument-list
     ,args))
 phps-mode-parser--table-translations)

;; 519 ((dereferenceable_scalar) (T_ARRAY "(" array_pair_list ")"))
(puthash
 519
 (lambda(args _terminals)
   `(
     ast-type
     dereferencable-scalar-array-pair
     array-pair-list
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 520 ((dereferenceable_scalar) ("[" array_pair_list "]"))
(puthash
 520
 (lambda(args _terminals)
   `(
     ast-type
     dereferencable-scalar-array-pair
     array-pair-list
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 521 ((dereferenceable_scalar) (T_CONSTANT_ENCAPSED_STRING))
(puthash
 521
 (lambda(args _terminals)
   `(
     ast-type
     dereferencable-scalar-constant-encapsed-string
     constant-encapsed-string
     ,args
     ))
 phps-mode-parser--table-translations)

;; 522 ((dereferenceable_scalar) ("\"" encaps_list "\""))
(puthash
 522
 (lambda(args _terminals)
   `(
     ast-type
     dereferencable-scalar-encaps-list
     encaps-list
     ,args
     ))
 phps-mode-parser--table-translations)

;; 523 ((scalar) (T_LNUMBER))
(puthash
 523
 (lambda(args _terminals)
   `(
     ast-type
     dereferencable-scalar-scalar
     scalar
     ,args
     ))
 phps-mode-parser--table-translations)

;; 524 ((scalar) (T_DNUMBER))
(puthash
 524
 (lambda(args _terminals)
   `(
     ast-type
     dereferencable-scalar-scalar
     scalar
     ,args
     ))
 phps-mode-parser--table-translations)

;; 525 ((scalar) (T_START_HEREDOC T_ENCAPSED_AND_WHITESPACE T_END_HEREDOC))
(puthash
 525
 (lambda(args _terminals)
   `(
     ast-type
     dereferencable-scalar-scalar
     scalar
     ,(nth 2 args)
     ))
 phps-mode-parser--table-translations)

;; 526 ((scalar) (T_START_HEREDOC T_END_HEREDOC))
(puthash
 526
 (lambda(_args _terminals)
   `(
     ast-type
     dereferencable-scalar-scalar
     scalar
     ""
     ))
 phps-mode-parser--table-translations)

;; 527 ((scalar) (T_START_HEREDOC encaps_list T_END_HEREDOC))
(puthash
 527
 (lambda(args _terminals)
   `(
     ast-type
     dereferencable-scalar-scalar
     scalar
     ,(nth 1 args)
     ))
 phps-mode-parser--table-translations)

;; 528 ((scalar) (dereferenceable_scalar))
(puthash
 528
 (lambda(args _terminals)
   `(
     ast-type
     scalar-dereferencable-scalar
     dereferenceable-scalar
     ,args
     ))
 phps-mode-parser--table-translations)

;; 529 ((scalar) (constant))
(puthash
 529
 (lambda(args _terminals)
   `(
     ast-type
     scalar-constant
     constant
     ,args
     ))
 phps-mode-parser--table-translations)

;; 530 ((scalar) (class_constant))
(puthash
 530
 (lambda(args _terminals)
   `(
     ast-type
     scalar-class-constant
     class-constant
     ,args
     ))
 phps-mode-parser--table-translations)

;; 531 ((constant) (name))
(puthash
 531
 (lambda(args _terminals)

   ;; TODO Should bookkeep symbol read here
   ;; (message "482: %S" args)
   ;; (let ((constant-name-type (plist-get args 'ast-type))
   ;;       (constant-name (plist-get args 'name))
   ;;       (constant-start (car (cdr terminals)))
   ;;       (constant-end (cdr (cdr terminals))))
   ;;   (cond

   ;;    ((equal constant-name-type 'string-name)
   ;;     ;; BLAHA
   ;;     ;; TODO When reading this symbol should check global namespace
   ;;     ;; and namespace constants for hit
   ;;     (let ((symbol-scope phps-mode-parser-sdt--bookkeeping-namespace))
   ;;       (push (list 'constant) symbol-scope)
   ;;       (push
   ;;        (list
   ;;         constant-name
   ;;         symbol-scope
   ;;         constant-start
   ;;         constant-end)
   ;;        phps-mode-parser-sdt--bookkeeping-symbol-stack)))

   ;;    ((equal constant-name-type 'qualified-name)
   ;;     ;; BLAHA\BLAHA
   ;;     ;; TODO Handle this
   ;;     )

   ;;    ((equal constant-name-type 'fully-qualified-name)
   ;;     ;; \BLAHA
   ;;     (let* ((constant-namespace)
   ;;            (string-pos 0)
   ;;            (namespace-pos
   ;;             (string-search "\\" constant-name string-pos))
   ;;            (namespace-last-pos namespace-pos))

   ;;       ;; Extract any potential constant namespace here
   ;;       (when namespace-pos
   ;;         (setq string-pos (1+ string-pos))
   ;;         (setq namespace-pos (string-search "\\" constant-name string-pos))
   ;;         (while namespace-pos
   ;;           (setq namespace-last-pos namespace-pos)
   ;;           (setq string-pos (1+ string-pos))
   ;;           (setq namespace-pos (string-search "\\" constant-name string-pos)))
   ;;         (unless (= namespace-last-pos 0)
   ;;           (setq
   ;;            constant-namespace
   ;;            (substring constant-name 1 namespace-last-pos)))
   ;;         (setq
   ;;          constant-name
   ;;          (substring constant-name (1+ namespace-last-pos))))

   ;;       (push
   ;;        (list
   ;;         constant-name
   ;;         (if constant-namespace `((namespace ,constant-namespace)) nil)
   ;;         constant-start
   ;;         constant-end)
   ;;        phps-mode-parser-sdt--bookkeeping-symbol-stack)))

   ;;    ((equal constant-name-type 'relative-name)
   ;;     ;; namespace\A inside namespace X\Y resolves to X\Y\A.
   ;;     ;; TODO Handle this
   ;;     )

   ;;    ))

   `(
     ast-type
     constant-name
     name
     ,args
     ))
 phps-mode-parser--table-translations)

;; 532 ((constant) (T_LINE))
(puthash
 532
 (lambda(_args _terminals)
   `(
     ast-type
     constant-line
     ))
 phps-mode-parser--table-translations)

;; 533 ((constant) (T_FILE))
(puthash
 533
 (lambda(_args _terminals)
   `(
     ast-type
     constant-file
     ))
 phps-mode-parser--table-translations)

;; 534 ((constant) (T_DIR))
(puthash
 534
 (lambda(_args _terminals)
   `(
     ast-type
     constant-dir
     ))
 phps-mode-parser--table-translations)

;; 535 ((constant) (T_TRAIT_C))
(puthash
 535
 (lambda(_args _terminals)
   `(
     ast-type
     constant-trait
     ))
 phps-mode-parser--table-translations)

;; 536 ((constant) (T_METHOD_C))
(puthash
 536
 (lambda(_args _terminals)
   `(
     ast-type
     constant-method
     ))
 phps-mode-parser--table-translations)

;; 537 ((constant) (T_FUNC_C))
(puthash
 537
 (lambda(_args _terminals)
   `(
     ast-type
     constant-function
     ))
 phps-mode-parser--table-translations)

;; 538 ((constant) (T_PROPERTY_C))
(puthash
 538
 (lambda(_args _terminals)
   `(
     ast-type
     constant-property
     ))
 phps-mode-parser--table-translations)

;; 539 ((constant) (T_NS_C))
(puthash
 539
 (lambda(_args _terminals)
   `(
     ast-type
     constant-namespace
     ))
 phps-mode-parser--table-translations)

;; 540 ((constant) (T_CLASS_C))
(puthash
 540
 (lambda(_args _terminals)
   `(
     ast-type
     constant-class
     ))
 phps-mode-parser--table-translations)

;; 541 ((class_constant) (class_name T_PAAMAYIM_NEKUDOTAYIM identifier))
(puthash
 541
 (lambda(args _terminals)
   `(
     ast-type
     class-constant-class-name
     class-name
     ,(nth 0 args)
     identifier
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 542 ((class_constant) (variable_class_name T_PAAMAYIM_NEKUDOTAYIM identifier))
(puthash
 542
 (lambda(args _terminals)
   `(
     ast-type
     class-constant-variable-class-name
     variable-class-name
     ,(nth 0 args)
     identifier
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 543 ((class_constant) (class_name T_PAAMAYIM_NEKUDOTAYIM "{" expr "}"))
(puthash
 543
 (lambda(args _terminals)
   `(
     ast-type
     class-constant-expr
     variable-class-name
     ,(nth 0 args)
     expr
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 544 ((class_constant) (variable_class_name T_PAAMAYIM_NEKUDOTAYIM "{" expr "}"))
(puthash
 544
 (lambda(args _terminals)
   `(
     ast-type
     class-constant-variable-class-name
     variable-class-name
     ,(nth 0 args)
     expr
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 545 ((optional_expr) (%empty))
(puthash
 545
 (lambda(_args _terminals)
   `(
     ast-type
     optional-expr-empty))
 phps-mode-parser--table-translations)

;; 546 ((optional_expr) (expr))
(puthash
 546
 (lambda(args _terminals)
   `(
     ast-type
     optional-expr-not-empty
     expr
     ,args))
 phps-mode-parser--table-translations)

;; 547 ((variable_class_name) (fully_dereferenceable))
(puthash
 547
 (lambda(args _terminals)
   `(
     ast-type
     variable-class-name
     fully-dereferenceable
     ,args))
 phps-mode-parser--table-translations)

;; 548 ((fully_dereferenceable) (variable))
(puthash
 548
 (lambda(args _terminals)
   `(
     ast-type
     fully-dereferenceable-variable
     variable
     ,args))
 phps-mode-parser--table-translations)

;; 549 ((fully_dereferenceable) ("(" expr ")"))
(puthash
 549
 (lambda(args _terminals)
   `(
     ast-type
     fully-dereferenceable-expr
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 550 ((fully_dereferenceable) (dereferenceable_scalar))
(puthash
 550
 (lambda(args _terminals)
   `(
     ast-type
     fully-dereferenceable-scalar
     dereferenceable-scalar
     ,args))
 phps-mode-parser--table-translations)

;; 551 ((fully_dereferenceable) (class_constant))
(puthash
 551
 (lambda(args _terminals)
   `(
     ast-type
     fully-dereferenceable-class-constant
     class-constant
     ,args))
 phps-mode-parser--table-translations)

;; 552 ((fully_dereferenceable) (new_dereferenceable))
(puthash
 552
 (lambda(args _terminals)
   `(
     ast-type
     fully-dereferenceable-new-dereferenceable
     new-dereferenceable
     ,args))
 phps-mode-parser--table-translations)

;; 553 ((array_object_dereferenceable) (fully_dereferenceable))
(puthash
 553
 (lambda(args _terminals)
   `(
     ast-type
     array-object-dereferenceable-fully-dereferenceable
     fully-dereferenceable
     ,args))
 phps-mode-parser--table-translations)

;; 554 ((array_object_dereferenceable) (constant))
(puthash
 554
 (lambda(args _terminals)
   `(
     ast-type
     array-object-dereferenceable-constant
     constant
     ,args))
 phps-mode-parser--table-translations)

;; 555 ((callable_expr) (callable_variable))
(puthash
 555
 (lambda(args _terminals)
   `(
     ast-type
     callable-expr-callable-variable
     callable-variable
     ,args))
 phps-mode-parser--table-translations)

;; 556 ((callable_expr) ("(" expr ")"))
(puthash
 556
 (lambda(args _terminals)
   `(
     ast-type
     callable-expr-expr
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 557 ((callable_expr) (dereferenceable_scalar))
(puthash
 557
 (lambda(args _terminals)
   `(
     ast-type
     callable-expr-dereferenceable-scalar
     ,args))
 phps-mode-parser--table-translations)

;; 558 ((callable_expr) (new_dereferenceable))
(puthash
 558
 (lambda(args _terminals)
   `(
     ast-type
     callable-expr-new-dereferenceable
     ,args))
 phps-mode-parser--table-translations)

;; 559 ((callable_variable) (simple_variable))
(puthash
 559
 (lambda(args _terminals)
   `(
     ast-type
     callable-variable-simple-variable
     simple-variable
     ,args))
 phps-mode-parser--table-translations)

;; 560 ((callable_variable) (array_object_dereferenceable "[" optional_expr "]"))
(puthash
 560
 (lambda(args _terminals)
   `(
     ast-type
     callable-variable-array-object-dereferenceable-indexed-expr
     array-object-dereferenceable
     ,(nth 0 args)
     optional-expr
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 561 ((callable_variable) (array_object_dereferenceable T_OBJECT_OPERATOR property_name argument_list))
(puthash
 561
 (lambda(args _terminals)
   `(
     ast-type
     callable-variable-array-object-dereferenceable-property-name
     array-object-dereferenceable
     ,(nth 0 args)
     property-name
     ,(nth 2 args)
     argument-list
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 562 ((callable_variable) (array_object_dereferenceable T_NULLSAFE_OBJECT_OPERATOR property_name argument_list))
(puthash
 562
 (lambda(args _terminals)
   `(
     ast-type
     callable-variable-array-object-dereferenceable-nullsafe-property-name
     array-object-dereferenceable
     ,(nth 0 args)
     property-name
     ,(nth 2 args)
     argument-list
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 563 ((callable_variable) (function_call))
(puthash
 563
 (lambda(args _terminals)
   `(
     ast-type
     callable-variable-function-call
     function-call
     ,args))
 phps-mode-parser--table-translations)

;; 564 ((variable) (callable_variable))
(puthash
 564
 (lambda(args _terminals)
   `(
     ast-type
     variable-callable-variable
     callable-variable
     ,args))
 phps-mode-parser--table-translations)

;; 565 ((variable) (static_member))
(puthash
 565
 (lambda(args _terminals)
   `(
     ast-type
     variable-static-member
     static-member
     ,args))
 phps-mode-parser--table-translations)

;; 566 ((variable) (array_object_dereferenceable T_OBJECT_OPERATOR property_name))
(puthash
 566
 (lambda(args terminals)
   (let* ((array-object-dereferenceable (nth 0 args))
          (array-object-dereferenceable-type
           (plist-get
            array-object-dereferenceable
            'ast-type)))
     (when (equal
            array-object-dereferenceable-type
            'array-object-dereferenceable-fully-dereferenceable)
       (let* ((dereferenceable
               (plist-get
                array-object-dereferenceable
                'fully-dereferenceable))
              (dereferencable-type
               (plist-get
                dereferenceable
                'ast-type)))
         (when (equal
                dereferencable-type
                'fully-dereferenceable-variable)
           (let* ((fully-dereferenceable-variable
                   (plist-get
                    dereferenceable
                    'variable))
                  (fully-dereferenceable-variable-type
                   (plist-get
                    fully-dereferenceable-variable
                    'ast-type)))
             (when (equal
                    fully-dereferenceable-variable-type
                    'variable-callable-variable)
               (let* ((callable-variable
                       (plist-get
                        fully-dereferenceable-variable
                        'callable-variable))
                      (callable-variable-type
                       (plist-get
                        callable-variable
                        'ast-type)))
                 (when (equal
                        callable-variable-type
                        'callable-variable-simple-variable)
                   (let* ((simple-variable
                           (plist-get
                            (plist-get
                             callable-variable
                             'simple-variable)
                            'variable)))
                     (push
                      (list
                       simple-variable
                       phps-mode-parser-sdt--bookkeeping-namespace
                       (car (cdr (nth 0 terminals)))
                       (cdr (cdr (nth 0 terminals))))
                      phps-mode-parser-sdt--bookkeeping-symbol-stack)
                     (let* ((property (nth 2 args))
                            (property-type (plist-get property 'ast-type)))
                       (when (equal
                              property-type
                              'property-name-string)
                         (let ((property-string
                                (plist-get
                                 property
                                 'string)))
                           (let ((namespace phps-mode-parser-sdt--bookkeeping-namespace))
                             (push (list 'object-operator simple-variable) namespace)
                             (push
                              (list
                               (format "$%s" property-string)
                               namespace
                               (car (cdr (nth 2 terminals)))
                               (cdr (cdr (nth 2 terminals))))
                              phps-mode-parser-sdt--bookkeeping-symbol-stack))))))))))))))
   `(
     ast-type
     variable-array-object-dereferenceable-property-name
     array-object-dereferenceable
     ,(nth 0 args)
     property-name
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 567 ((variable) (array_object_dereferenceable T_NULLSAFE_OBJECT_OPERATOR property_name))
(puthash
 567
 (lambda(args _terminals)
   `(
     ast-type
     variable-array-object-dereferenceable-nullsafe-property-name
     array-object-dereferenceable
     ,(nth 0 args)
     property-name
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 568 ((simple_variable) (T_VARIABLE))
(puthash
 568
 (lambda(args terminals)
   (let ((symbol-name
           args)
         (symbol-start
          (car (cdr terminals)))
         (symbol-end
          (cdr (cdr terminals)))
         (namespace phps-mode-parser-sdt--bookkeeping-namespace))
     (push
      (list
       symbol-name
       namespace
       symbol-start
       symbol-end)
      phps-mode-parser-sdt--bookkeeping-symbol-stack))

   `(
     ast-type
     simple-variable-variable
     ast-start
     ,(car (cdr terminals))
     ast-end
     ,(cdr (cdr terminals))
     variable
     ,args))
 phps-mode-parser--table-translations)

;; 569 ((simple_variable) ("$" "{" expr "}"))
(puthash
 569
 (lambda(args _terminals)
   `(
     ast-type
     simple-variable-expr
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 570 ((simple_variable) ("$" simple_variable))
(puthash
 570
 (lambda(args terminals)
   `(
     ast-type
     simple-variable-variable
     ,(nth 1 args)
     ast-start
     ,(car (cdr (nth 1 terminals)))
     ast-end
     ,(cdr (cdr (nth 1 terminals)))
     ))
 phps-mode-parser--table-translations)

;; 571 ((static_member) (class_name T_PAAMAYIM_NEKUDOTAYIM simple_variable))
(puthash
 571
 (lambda(args _terminals)
   (let* ((class-name (nth 0 args))
          (class-name-type (plist-get class-name 'ast-type)))
     (cond
      ((equal class-name-type 'class-name-name)
       (let ((class-name-string (plist-get class-name 'name))
             (namespace phps-mode-parser-sdt--bookkeeping-namespace))
         (push (list 'static-member class-name-string) namespace)
         (setf
          (nth 1 (car phps-mode-parser-sdt--bookkeeping-symbol-stack))
          namespace)))
      ((equal class-name-type 'class-name-static)
       (let ((namespace phps-mode-parser-sdt--bookkeeping-namespace))
         (push (list 'static-member (list 'ast-type 'string-name 'name "static")) namespace)
         (setf
          (nth 1 (car phps-mode-parser-sdt--bookkeeping-symbol-stack))
          namespace)))))
   `(
     ast-type
     static-member-class-name
     class-name
     ,(nth 0 args)
     simple-variable
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 572 ((static_member) (variable_class_name T_PAAMAYIM_NEKUDOTAYIM simple_variable))
(puthash
 572
 (lambda(args _terminals)
   ;; TODO Add bookkeeping here
   `(
     ast-type
     static-member-variable-class-name
     variable-class-name
     ,(nth 0 args)
     simple-variable
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 573 ((new_variable) (simple_variable))
(puthash
 573
 (lambda(args _terminals)
   `(
     ast-type
     new-variable-simple-variable
     simple-variable
     ,args))
 phps-mode-parser--table-translations)

;; 574 ((new_variable) (new_variable "[" optional_expr "]"))
(puthash
 574
 (lambda(args _terminals)
   `(
     ast-type
     new-variable-optional-expr
     new-variable
     ,(nth 0 args)
     optional-expr
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 575 ((new_variable) (new_variable T_OBJECT_OPERATOR property_name))
(puthash
 575
 (lambda(args _terminals)
   `(
     ast-type
     new-variable-property-name
     new-variable
     ,(nth 0 args)
     property-name
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 576 ((new_variable) (new_variable T_NULLSAFE_OBJECT_OPERATOR property_name))
(puthash
 576
 (lambda(args _terminals)
   `(
     ast-type
     new-variable-nullsafe-property-name
     new-variable
     ,(nth 0 args)
     property-name
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 577 ((new_variable) (class_name T_PAAMAYIM_NEKUDOTAYIM simple_variable))
(puthash
 577
 (lambda(args _terminals)
   `(
     ast-type
     new-variable-class-name
     class-name
     ,(nth 0 args)
     simple-variable
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 578 ((new_variable) (new_variable T_PAAMAYIM_NEKUDOTAYIM simple_variable))
(puthash
 578
 (lambda(args _terminals)
   `(
     ast-type
     new-variable-simple-variable
     new-variable
     ,(nth 0 args)
     simple-variable
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 579 ((member_name) (identifier))
(puthash
 579
 (lambda(args _terminals)
   `(
     ast-type
     member-name-identifier
     identifier
     ,args))
 phps-mode-parser--table-translations)

;; 580 ((member_name) ("{" expr "}"))
(puthash
 580
 (lambda(args _terminals)
   `(
     ast-type
     member-name-expr
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 581 ((member_name) (simple_variable))
(puthash
 581
 (lambda(args _terminals)
   `(
     ast-type
     member-name-simple-variable
     simple-variable
     ,args))
 phps-mode-parser--table-translations)

;; 582 ((property_name) (T_STRING))
(puthash
 582
 (lambda(args _terminals)
   `(
     ast-type
     property-name-string
     string
     ,args))
 phps-mode-parser--table-translations)

;; 583 ((property_name) ("{" expr "}"))
(puthash
 583
 (lambda(args _terminals)
   `(
     ast-type
     properyt-name-expr
     expr
     ,args))
 phps-mode-parser--table-translations)

;; 584 ((property_name) (simple_variable))
(puthash
 584
 (lambda(args _terminals)
   `(
     ast-type
     property-name-simple-variable
     simple-variable
     ,args))
 phps-mode-parser--table-translations)

;; 585 ((array_pair_list) (non_empty_array_pair_list))
(puthash
 585
 (lambda(args _terminals)
   args)
 phps-mode-parser--table-translations)

;; 586 ((possible_array_pair) (%empty))
(puthash
 586
 (lambda(_args _terminals)
   nil)
 phps-mode-parser--table-translations)

;; 587 ((possible_array_pair) (array_pair))
(puthash
 587
 (lambda(args _terminals)
   args)
 phps-mode-parser--table-translations)

;; 588 ((non_empty_array_pair_list) (non_empty_array_pair_list "," possible_array_pair))
(puthash
 588
 (lambda(args _terminals)
   (if (nth 2 args)
       (append (nth 0 args) (list (nth 2 args)))
     (nth 0 args)))
 phps-mode-parser--table-translations)

;; 589 ((non_empty_array_pair_list) (possible_array_pair))
(puthash
 589
 (lambda(args _terminals)
   (list args))
 phps-mode-parser--table-translations)

;; 590 ((array_pair) (expr T_DOUBLE_ARROW expr))
(puthash
 590
 (lambda(args _terminals)
   `(
     ast-type
     array-pair-expr1-double-arrow-expr2
     expr1
     ,(nth 0 args)
     expr2
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 591 ((array_pair) (expr))
(puthash
 591
 (lambda(args _terminals)
   `(
     ast-type
     array-pair-expr
     expr
     ,args))
 phps-mode-parser--table-translations)

;; 592 ((array_pair) (expr T_DOUBLE_ARROW ampersand variable))
(puthash
 592
 (lambda(args _terminals)
   `(
     ast-type
     array-pair-expr-double-arrow-referenced-variable
     expr
     ,(nth 0 args)
     referenced-variable
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 593 ((array_pair) (ampersand variable))
(puthash
 593
 (lambda(args _terminals)
   `(
     ast-type
     array-pair-referenced-variable
     referenced-variable
     ,args))
 phps-mode-parser--table-translations)

;; 594 ((array_pair) (T_ELLIPSIS expr))
(puthash
 577
 (lambda(args _terminals)
   `(
     ast-type
     array-pair-ellipsis-expr
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 595 ((array_pair) (expr T_DOUBLE_ARROW T_LIST "(" array_pair_list ")"))
(puthash
 595
 (lambda(args _terminals)
   `(
     ast-type
     array-pair-double-arrow-list
     expr
     ,(nth 0 args)
     array-pair-list
     ,(nth 4 args)))
 phps-mode-parser--table-translations)

;; 596 ((array_pair) (T_LIST "(" array_pair_list ")"))
(puthash
 596
 (lambda(args _terminals)
   `(
     ast-type
     array-pair-list
     array-pair-list
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 597 ((encaps_list) (encaps_list encaps_var))
(puthash
 597
 (lambda(args _terminals)
   `(
     ast-type
     escaps-list-encaps-list
     ,(append (nth 0 args) (list (nth 1 args)))))
 phps-mode-parser--table-translations)

;; 598 ((encaps_list) (encaps_list T_ENCAPSED_AND_WHITESPACE))
(puthash
 598
 (lambda(args _terminals)
   `(
     ast-type
     escaps-list-encapsed-and-whitespace
     encaps-list
     ,(nth 0 args)
     encapsed-and-whitespace
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 599 ((encaps_list) (encaps_var))
(puthash
 599
 (lambda(args _terminals)
   `(
     ast-type
     escaps-list-encaps-var
     encaps-var
     ,args))
 phps-mode-parser--table-translations)

;; 600 ((encaps_list) (T_ENCAPSED_AND_WHITESPACE encaps_var))
(puthash
 600
 (lambda(args _terminals)
   `(
     ast-type
     escaps-list-enscapsed-and-whitespace-encaps-var
     encapsed-and-whitespace
     ,(nth 0 args)
     encaps-var
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 601 ((encaps_var) (T_VARIABLE))
(puthash
 601
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-variable
     variable
     ,args))
 phps-mode-parser--table-translations)

;; 602 ((encaps_var) (T_VARIABLE "[" encaps_var_offset "]"))
(puthash
 602
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-variable-with-offset
     variable
     ,(nth 0 args)
     encaps-var-offset
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 603 ((encaps_var) (T_VARIABLE T_OBJECT_OPERATOR T_STRING))
(puthash
 603
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-variable-property
     variable
     ,(nth 0 args)
     property
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 604 ((encaps_var) (T_VARIABLE T_NULLSAFE_OBJECT_OPERATOR T_STRING))
(puthash
 604
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-variable-nullsafe-property
     variable
     ,(nth 0 args)
     property
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 605 ((encaps_var) (T_DOLLAR_OPEN_CURLY_BRACES expr "}"))
(puthash
 605
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-braces-expr
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 606 ((encaps_var) (T_DOLLAR_OPEN_CURLY_BRACES T_STRING_VARNAME "}"))
(puthash
 606
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-braces-string-varname
     string-varname
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 607 ((encaps_var) (T_DOLLAR_OPEN_CURLY_BRACES T_STRING_VARNAME "[" expr "]" "}"))
(puthash
 607
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-braces-string-varname-indexed-expr
     string-varname
     ,(nth 1 args)
     indexed-expr
     ,(nth 3 args)))
 phps-mode-parser--table-translations)

;; 608 ((encaps_var) (T_CURLY_OPEN variable "}"))
(puthash
 608
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-curly-open-variable
     variable
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 609 ((encaps_var_offset) (T_STRING))
(puthash
 609
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-offset-string
     string
     ,args))
 phps-mode-parser--table-translations)

;; 610 ((encaps_var_offset) (T_NUM_STRING))
(puthash
 610
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-offset-num-string
     num-string
     ,args))
 phps-mode-parser--table-translations)

;; 611 ((encaps_var_offset) ("-" T_NUM_STRING))
(puthash
 611
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-offset-negative-num-string
     num-string
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 612 ((encaps_var_offset) (T_VARIABLE))
(puthash
 612
 (lambda(args _terminals)
   `(
     ast-type
     encaps-var-offset-variable
     variable
     ,args))
 phps-mode-parser--table-translations)

;; 613 ((internal_functions_in_yacc) (T_ISSET "(" isset_variables possible_comma ")"))
(puthash
 613
 (lambda(args terminals)
   (when phps-mode-parser-sdt--bookkeeping-symbol-stack
     (let ((isset-start (car (cdr (nth 1 terminals))))
           (isset-end (cdr (cdr (nth 4 terminals)))))
       (dolist (item phps-mode-parser-sdt--bookkeeping-symbol-stack)
         (let ((item-start (nth 2 item))
               (item-end (nth 3 item)))
           (when (and
                  (> item-start isset-start)
                  (< item-end isset-end))
             (push
              (list
               (nth 0 item)
               phps-mode-parser-sdt--bookkeeping-namespace
               item-start
               item-end)
             phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))))))
   `(
     ast-type
     internal-isset
     isset-variables
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 614 ((internal_functions_in_yacc) (T_EMPTY "(" expr ")"))
(puthash
 614
 (lambda(args terminals)
   (when phps-mode-parser-sdt--bookkeeping-symbol-stack
     (let ((empty-start (car (cdr (nth 1 terminals))))
           (empty-end (cdr (cdr (nth 3 terminals)))))
       (dolist (item phps-mode-parser-sdt--bookkeeping-symbol-stack)
         (let ((item-start (nth 2 item))
               (item-end (nth 3 item)))
           (when (and
                  (> item-start empty-start)
                  (< item-end empty-end))
             (push
              (list
               (nth 0 item)
               phps-mode-parser-sdt--bookkeeping-namespace
               item-start
               item-end)
              phps-mode-parser-sdt--bookkeeping-symbol-assignment-stack))))))
   `(
     ast-type
     internal-empty-expr
     expr
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 615 ((internal_functions_in_yacc) (T_INCLUDE expr))
(puthash
 615
 (lambda(args _terminals)
   `(
     ast-type
     internal-include-expr
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 616 ((internal_functions_in_yacc) (T_INCLUDE_ONCE expr))
(puthash
 616
 (lambda(args _terminals)
   `(
     ast-type
     internal-include-once
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 617 ((internal_functions_in_yacc) (T_EVAL "(" expr ")"))
(puthash
 617
 (lambda(args _terminals)
   `(
     ast-type
     internal-eval
     expr
     ,(nth 2 args)))
 phps-mode-parser--table-translations)

;; 618 ((internal_functions_in_yacc) (T_REQUIRE expr))
(puthash
 618
 (lambda(args _terminals)
   `(
     ast-type
     internal-require
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 619 ((internal_functions_in_yacc) (T_REQUIRE_ONCE expr))
(puthash
 619
 (lambda(args _terminals)
   `(
     ast-type
     internal-require-once
     expr
     ,(nth 1 args)))
 phps-mode-parser--table-translations)

;; 620 ((isset_variables) (isset_variable))
(puthash
 620
 (lambda(args _terminals)
   (list args))
 phps-mode-parser--table-translations)

;; 621 ((isset_variables) (isset_variables "," isset_variable))
(puthash
 621
 (lambda(args _terminals)
   (append (nth 0 args) (nth 2 args)))
 phps-mode-parser--table-translations)

;; 622 ((isset_variable) (expr))
(puthash
 622
 (lambda(args _terminals)
   args)
 phps-mode-parser--table-translations)

(provide 'phps-mode-parser-sdt)
;;; phps-mode-parser-sdt.el ends here
