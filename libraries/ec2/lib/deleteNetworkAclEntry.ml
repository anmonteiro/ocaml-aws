open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteNetworkAclEntryRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      egress: Boolean.t
        [@ocaml.doc "<p>Indicates whether the rule is an egress rule.</p>"];
      network_acl_id: String.t
        [@ocaml.doc "<p>The ID of the network ACL.</p>"];
      rule_number: Integer.t
        [@ocaml.doc "<p>The rule number of the entry to delete.</p>"]}
    let make ?dry_run  ~egress  ~network_acl_id  ~rule_number  () =
      { dry_run; egress; network_acl_id; rule_number }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair ("RuleNumber", (Integer.to_query v.rule_number)));
           Some
             (Query.Pair ("NetworkAclId", (String.to_query v.network_acl_id)));
           Some (Query.Pair ("Egress", (Boolean.to_query v.egress)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rule_number", (Integer.to_json v.rule_number));
           Some ("network_acl_id", (String.to_json v.network_acl_id));
           Some ("egress", (Boolean.to_json v.egress));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          egress =
            (Xml.required "egress"
               (Util.option_bind (Xml.member "egress" xml) Boolean.parse));
          network_acl_id =
            (Xml.required "networkAclId"
               (Util.option_bind (Xml.member "networkAclId" xml) String.parse));
          rule_number =
            (Xml.required "ruleNumber"
               (Util.option_bind (Xml.member "ruleNumber" xml) Integer.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
             @
             [Some (Ezxmlm.make_tag "egress" ([], (Boolean.to_xml v.egress)))])
            @
            [Some
               (Ezxmlm.make_tag "networkAclId"
                  ([], (String.to_xml v.network_acl_id)))])
           @
           [Some
              (Ezxmlm.make_tag "ruleNumber"
                 ([], (Integer.to_xml v.rule_number)))])
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteNetworkAclEntryRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DeleteNetworkAclEntry"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteNetworkAclEntryRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteNetworkAclEntryRequest.to_headers req)), "")
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