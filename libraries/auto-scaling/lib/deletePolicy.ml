open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeletePolicyType =
  struct
    type t =
      {
      auto_scaling_group_name: String.t option
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      policy_name: String.t
        [@ocaml.doc
          "<p>The name or Amazon Resource Name (ARN) of the policy.</p>"]}
    let make ?auto_scaling_group_name  ~policy_name  () =
      { auto_scaling_group_name; policy_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("policy_name", (String.to_json v.policy_name));
           Util.option_map v.auto_scaling_group_name
             (fun f -> ("auto_scaling_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
               String.parse);
          policy_name =
            (Xml.required "PolicyName"
               (Util.option_bind (Xml.member "PolicyName" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.auto_scaling_group_name
               (fun f ->
                  Ezxmlm.make_tag "AutoScalingGroupName"
                    ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "PolicyName"
                 ([], (String.to_xml v.policy_name)))])
  end
module Output = Aws.BaseTypes.Unit
type input = DeletePolicyType.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]); ("Action", ["DeletePolicy"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeletePolicyType.to_query req))))) in
  (`POST, uri, (Headers.render (DeletePolicyType.to_headers req)), "")
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