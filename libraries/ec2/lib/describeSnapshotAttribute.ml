open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeSnapshotAttributeRequest =
  struct
    type t =
      {
      attribute: SnapshotAttributeName.t
        [@ocaml.doc "<p>The snapshot attribute you would like to view.</p>"];
      snapshot_id: String.t [@ocaml.doc "<p>The ID of the EBS snapshot.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~attribute  ~snapshot_id  ?dry_run  () =
      { attribute; snapshot_id; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("SnapshotId", (String.to_query v.snapshot_id)));
           Some
             (Query.Pair
                ("Attribute", (SnapshotAttributeName.to_query v.attribute)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("snapshot_id", (String.to_json v.snapshot_id));
           Some ("attribute", (SnapshotAttributeName.to_json v.attribute))])
    let parse xml =
      Some
        {
          attribute =
            (Xml.required "Attribute"
               (Util.option_bind (Xml.member "Attribute" xml)
                  SnapshotAttributeName.parse));
          snapshot_id =
            (Xml.required "SnapshotId"
               (Util.option_bind (Xml.member "SnapshotId" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "Attribute"
                   ([], (SnapshotAttributeName.to_xml v.attribute)))])
            @
            [Some
               (Ezxmlm.make_tag "SnapshotId"
                  ([], (String.to_xml v.snapshot_id)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module DescribeSnapshotAttributeResult = DescribeSnapshotAttributeResult
type input = DescribeSnapshotAttributeRequest.t
type output = DescribeSnapshotAttributeResult.t
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
         ("Action", ["DescribeSnapshotAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeSnapshotAttributeRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeSnapshotAttributeRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeSnapshotAttributeResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeSnapshotAttributeResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeSnapshotAttributeResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeSnapshotAttributeResult - missing field in body or children: "
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