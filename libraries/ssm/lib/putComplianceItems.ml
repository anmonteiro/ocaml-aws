open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutComplianceItemsRequest =
  struct
    type t =
      {
      resource_id: String.t
        [@ocaml.doc
          "<p>Specify an ID for this resource. For a managed instance, this is the instance ID.</p>"];
      resource_type: String.t
        [@ocaml.doc
          "<p>Specify the type of resource. <code>ManagedInstance</code> is currently the only supported resource type.</p>"];
      compliance_type: String.t
        [@ocaml.doc
          "<p>Specify the compliance type. For example, specify Association (for a State Manager association), Patch, or Custom:<code>string</code>.</p>"];
      execution_summary: ComplianceExecutionSummary.t
        [@ocaml.doc
          "<p>A summary of the call execution that includes an execution ID, the type of execution (for example, <code>Command</code>), and the date/time of the execution using a datetime object that is saved in the following format: yyyy-MM-dd'T'HH:mm:ss'Z'.</p>"];
      items: ComplianceItemEntryList.t
        [@ocaml.doc
          "<p>Information about the compliance as defined by the resource type. For example, for a patch compliance type, <code>Items</code> includes information about the PatchSeverity, Classification, etc.</p>"];
      item_content_hash: String.t option
        [@ocaml.doc
          "<p>MD5 or SHA-256 content hash. The content hash is used to determine if existing information should be overwritten or ignored. If the content hashes match, the request to put compliance information is ignored.</p>"]}
    let make ~resource_id  ~resource_type  ~compliance_type 
      ~execution_summary  ~items  ?item_content_hash  () =
      {
        resource_id;
        resource_type;
        compliance_type;
        execution_summary;
        items;
        item_content_hash
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.item_content_hash
              (fun f -> ("item_content_hash", (String.to_json f)));
           Some ("items", (ComplianceItemEntryList.to_json v.items));
           Some
             ("execution_summary",
               (ComplianceExecutionSummary.to_json v.execution_summary));
           Some ("compliance_type", (String.to_json v.compliance_type));
           Some ("resource_type", (String.to_json v.resource_type));
           Some ("resource_id", (String.to_json v.resource_id))])
    let of_json j =
      {
        resource_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "resource_id")));
        resource_type =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "resource_type")));
        compliance_type =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "compliance_type")));
        execution_summary =
          (ComplianceExecutionSummary.of_json
             (Util.of_option_exn (Json.lookup j "execution_summary")));
        items =
          (ComplianceItemEntryList.of_json
             (Util.of_option_exn (Json.lookup j "items")));
        item_content_hash =
          (Util.option_map (Json.lookup j "item_content_hash") String.of_json)
      }
  end
module Output = Aws.BaseTypes.Unit
type input = PutComplianceItemsRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutComplianceItemsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (PutComplianceItemsRequest.to_headers req)),
    "")
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