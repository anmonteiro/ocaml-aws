open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateActivationRequest =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc
          "<p>A user-defined description of the resource that you want to register with Amazon EC2. </p> <important> <p>Do not enter personally identifiable information in this field.</p> </important>"];
      default_instance_name: String.t option
        [@ocaml.doc
          "<p>The name of the registered, managed instance as it will appear in the Amazon EC2 console or when you use the AWS command line tools to list EC2 resources.</p> <important> <p>Do not enter personally identifiable information in this field.</p> </important>"];
      iam_role: String.t
        [@ocaml.doc
          "<p>The Amazon Identity and Access Management (IAM) role that you want to assign to the managed instance. </p>"];
      registration_limit: Integer.t option
        [@ocaml.doc
          "<p>Specify the maximum number of managed instances you want to register. The default value is 1 instance.</p>"];
      expiration_date: DateTime.t option
        [@ocaml.doc
          "<p>The date by which this activation request should expire. The default value is 24 hours.</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>Optional metadata that you assign to a resource. Tags enable you to categorize a resource in different ways, such as by purpose, owner, or environment. For example, you might want to tag an activation to identify which servers or virtual machines (VMs) in your on-premises environment you intend to activate. In this case, you could specify the following key name/value pairs:</p> <ul> <li> <p> <code>Key=OS,Value=Windows</code> </p> </li> <li> <p> <code>Key=Environment,Value=Production</code> </p> </li> </ul> <important> <p>When you install SSM Agent on your on-premises servers and VMs, you specify an activation ID and code. When you specify the activation ID and code, tags assigned to the activation are automatically applied to the on-premises servers or VMs.</p> </important> <p>You can't add tags to or delete tags from an existing activation. You can tag your on-premises servers and VMs after they connect to Systems Manager for the first time and are assigned a managed instance ID. This means they are listed in the AWS Systems Manager console with an ID that is prefixed with \"mi-\". For information about how to add tags to your managed instances, see <a>AddTagsToResource</a>. For information about how to remove tags from your managed instances, see <a>RemoveTagsFromResource</a>.</p>"]}
    let make ?description  ?default_instance_name  ~iam_role 
      ?registration_limit  ?expiration_date  ?(tags= [])  () =
      {
        description;
        default_instance_name;
        iam_role;
        registration_limit;
        expiration_date;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.expiration_date
             (fun f -> ("expiration_date", (DateTime.to_json f)));
           Util.option_map v.registration_limit
             (fun f -> ("registration_limit", (Integer.to_json f)));
           Some ("iam_role", (String.to_json v.iam_role));
           Util.option_map v.default_instance_name
             (fun f -> ("default_instance_name", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let of_json j =
      {
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        default_instance_name =
          (Util.option_map (Json.lookup j "default_instance_name")
             String.of_json);
        iam_role =
          (String.of_json (Util.of_option_exn (Json.lookup j "iam_role")));
        registration_limit =
          (Util.option_map (Json.lookup j "registration_limit")
             Integer.of_json);
        expiration_date =
          (Util.option_map (Json.lookup j "expiration_date") DateTime.of_json);
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module CreateActivationResult = CreateActivationResult
type input = CreateActivationRequest.t
type output = CreateActivationResult.t
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
            (Query.render (CreateActivationRequest.to_query req)))) in
  (`POST, uri, (Headers.render (CreateActivationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (CreateActivationResult.of_json json)
  with
  | Yojson.Json_error msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
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