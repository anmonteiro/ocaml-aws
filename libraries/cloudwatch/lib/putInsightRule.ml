open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutInsightRuleInput =
  struct
    type t =
      {
      rule_name: String.t [@ocaml.doc "<p>A unique name for the rule.</p>"];
      rule_state: String.t option
        [@ocaml.doc
          "<p>The state of the rule. Valid values are ENABLED and DISABLED.</p>"];
      rule_definition: String.t
        [@ocaml.doc
          "<p>The definition of the rule, as a JSON object. For details on the valid syntax, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContributorInsights-RuleSyntax.html\">Contributor Insights Rule Syntax</a>.</p>"]}
    let make ~rule_name  ?rule_state  ~rule_definition  () =
      { rule_name; rule_state; rule_definition }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rule_definition", (String.to_json v.rule_definition));
           Util.option_map v.rule_state
             (fun f -> ("rule_state", (String.to_json f)));
           Some ("rule_name", (String.to_json v.rule_name))])
    let parse xml =
      Some
        {
          rule_name =
            (Xml.required "RuleName"
               (Util.option_bind (Xml.member "RuleName" xml) String.parse));
          rule_state =
            (Util.option_bind (Xml.member "RuleState" xml) String.parse);
          rule_definition =
            (Xml.required "RuleDefinition"
               (Util.option_bind (Xml.member "RuleDefinition" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "RuleName" ([], (String.to_xml v.rule_name)))])
            @
            [Util.option_map v.rule_state
               (fun f -> Ezxmlm.make_tag "RuleState" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "RuleDefinition"
                 ([], (String.to_xml v.rule_definition)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutInsightRuleInput.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["PutInsightRule"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PutInsightRuleInput.to_query req))))) in
  (`POST, uri, (Headers.render (PutInsightRuleInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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