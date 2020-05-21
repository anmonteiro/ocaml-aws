open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeInstanceAttributeRequest =
  struct
    type t =
      {
      attribute: InstanceAttributeName.t
        [@ocaml.doc
          "<p>The instance attribute.</p> <p>Note: The <code>enaSupport</code> attribute is not supported at this time.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      instance_id: String.t [@ocaml.doc "<p>The ID of the instance.</p>"]}
    let make ~attribute  ?dry_run  ~instance_id  () =
      { attribute; dry_run; instance_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("InstanceId", (String.to_query v.instance_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("Attribute", (InstanceAttributeName.to_query v.attribute)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("instance_id", (String.to_json v.instance_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("attribute", (InstanceAttributeName.to_json v.attribute))])
    let parse xml =
      Some
        {
          attribute =
            (Xml.required "attribute"
               (Util.option_bind (Xml.member "attribute" xml)
                  InstanceAttributeName.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          instance_id =
            (Xml.required "instanceId"
               (Util.option_bind (Xml.member "instanceId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "attribute"
                   ([], (InstanceAttributeName.to_xml v.attribute)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "instanceId"
                 ([], (String.to_xml v.instance_id)))])
  end
module InstanceAttribute = InstanceAttribute
type input = DescribeInstanceAttributeRequest.t
type output = InstanceAttribute.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["DescribeInstanceAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeInstanceAttributeRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeInstanceAttributeRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeInstanceAttributeResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp InstanceAttribute.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed InstanceAttribute."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing InstanceAttribute - missing field in body or children: "
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