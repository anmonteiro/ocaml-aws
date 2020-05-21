open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateSnapshotsRequest =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc
          "<p> A description propagated to every snapshot specified by the instance.</p>"];
      instance_specification: InstanceSpecification.t
        [@ocaml.doc
          "<p>The instance to specify which volumes should be included in the snapshots.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc
          "<p>Tags to apply to every snapshot specified by the instance.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      copy_tags_from_source: CopyTagsFromSource.t option
        [@ocaml.doc
          "<p>Copies the tags from the specified volume to corresponding snapshot.</p>"]}
    let make ?description  ~instance_specification  ?(tag_specifications= [])
       ?dry_run  ?copy_tags_from_source  () =
      {
        description;
        instance_specification;
        tag_specifications;
        dry_run;
        copy_tags_from_source
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.copy_tags_from_source
              (fun f ->
                 Query.Pair
                   ("CopyTagsFromSource", (CopyTagsFromSource.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("TagSpecification",
                  (TagSpecificationList.to_query v.tag_specifications)));
           Some
             (Query.Pair
                ("InstanceSpecification",
                  (InstanceSpecification.to_query v.instance_specification)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.copy_tags_from_source
              (fun f ->
                 ("copy_tags_from_source", (CopyTagsFromSource.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("tag_specifications",
               (TagSpecificationList.to_json v.tag_specifications));
           Some
             ("instance_specification",
               (InstanceSpecification.to_json v.instance_specification));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let parse xml =
      Some
        {
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          instance_specification =
            (Xml.required "InstanceSpecification"
               (Util.option_bind (Xml.member "InstanceSpecification" xml)
                  InstanceSpecification.parse));
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          copy_tags_from_source =
            (Util.option_bind (Xml.member "CopyTagsFromSource" xml)
               CopyTagsFromSource.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.description
                  (fun f ->
                     Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
              @
              [Some
                 (Ezxmlm.make_tag "InstanceSpecification"
                    ([],
                      (InstanceSpecification.to_xml v.instance_specification)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "TagSpecification"
                        ([], (TagSpecificationList.to_xml [x]))))
                v.tag_specifications))
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.copy_tags_from_source
              (fun f ->
                 Ezxmlm.make_tag "CopyTagsFromSource"
                   ([], (CopyTagsFromSource.to_xml f)))])
  end
module CreateSnapshotsResult = CreateSnapshotsResult
type input = CreateSnapshotsRequest.t
type output = CreateSnapshotsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateSnapshots"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateSnapshotsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateSnapshotsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateSnapshotsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateSnapshotsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateSnapshotsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateSnapshotsResult - missing field in body or children: "
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