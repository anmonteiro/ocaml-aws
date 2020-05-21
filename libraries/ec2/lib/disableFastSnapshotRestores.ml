open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DisableFastSnapshotRestoresRequest =
  struct
    type t =
      {
      availability_zones: AvailabilityZoneStringList.t
        [@ocaml.doc
          "<p>One or more Availability Zones. For example, <code>us-east-2a</code>.</p>"];
      source_snapshot_ids: SnapshotIdStringList.t
        [@ocaml.doc
          "<p>The IDs of one or more snapshots. For example, <code>snap-1234567890abcdef0</code>.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~availability_zones  ~source_snapshot_ids  ?dry_run  () =
      { availability_zones; source_snapshot_ids; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("SourceSnapshotId",
                  (SnapshotIdStringList.to_query v.source_snapshot_ids)));
           Some
             (Query.Pair
                ("AvailabilityZone",
                  (AvailabilityZoneStringList.to_query v.availability_zones)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("source_snapshot_ids",
               (SnapshotIdStringList.to_json v.source_snapshot_ids));
           Some
             ("availability_zones",
               (AvailabilityZoneStringList.to_json v.availability_zones))])
    let parse xml =
      Some
        {
          availability_zones =
            (Xml.required "AvailabilityZone"
               (Util.option_bind (Xml.member "AvailabilityZone" xml)
                  AvailabilityZoneStringList.parse));
          source_snapshot_ids =
            (Xml.required "SourceSnapshotId"
               (Util.option_bind (Xml.member "SourceSnapshotId" xml)
                  SnapshotIdStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "AvailabilityZone"
                        ([], (AvailabilityZoneStringList.to_xml [x]))))
                v.availability_zones))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "SourceSnapshotId"
                       ([], (SnapshotIdStringList.to_xml [x]))))
               v.source_snapshot_ids))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module DisableFastSnapshotRestoresResult = DisableFastSnapshotRestoresResult
type input = DisableFastSnapshotRestoresRequest.t
type output = DisableFastSnapshotRestoresResult.t
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
         ("Action", ["DisableFastSnapshotRestores"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DisableFastSnapshotRestoresRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DisableFastSnapshotRestoresRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DisableFastSnapshotRestoresResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DisableFastSnapshotRestoresResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DisableFastSnapshotRestoresResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DisableFastSnapshotRestoresResult - missing field in body or children: "
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