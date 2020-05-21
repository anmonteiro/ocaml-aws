open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module EnableInsightRulesInput =
  struct
    type t =
      {
      rule_names: InsightRuleNames.t
        [@ocaml.doc
          "<p>An array of the rule names to enable. If you need to find out the names of your rules, use <a>DescribeInsightRules</a>.</p>"]}
    let make ~rule_names  () = { rule_names }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rule_names", (InsightRuleNames.to_json v.rule_names))])
    let parse xml =
      Some
        {
          rule_names =
            (Xml.required "RuleNames"
               (Util.option_bind (Xml.member "RuleNames" xml)
                  InsightRuleNames.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "RuleNames"
                      ([], (InsightRuleNames.to_xml [x])))) v.rule_names))
  end
module EnableInsightRulesOutput = EnableInsightRulesOutput
type input = EnableInsightRulesInput.t
type output = EnableInsightRulesOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["EnableInsightRules"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (EnableInsightRulesInput.to_query req))))) in
  (`POST, uri, (Headers.render (EnableInsightRulesInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "EnableInsightRulesResponse" (snd xml))
        (Xml.member "EnableInsightRulesResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp EnableInsightRulesOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed EnableInsightRulesOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing EnableInsightRulesOutput - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None