open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CopyOptionGroupMessage =
  struct
    type t =
      {
      source_option_group_identifier: String.t
        [@ocaml.doc
          "<p>The identifier or ARN for the source option group. For information about creating an ARN, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.ARN.html#USER_Tagging.ARN.Constructing\"> Constructing an ARN for Amazon RDS</a> in the <i>Amazon RDS User Guide</i>. </p> <p>Constraints:</p> <ul> <li> <p>Must specify a valid option group.</p> </li> <li> <p>If the source option group is in the same AWS Region as the copy, specify a valid option group identifier, for example <code>my-option-group</code>, or a valid ARN.</p> </li> <li> <p>If the source option group is in a different AWS Region than the copy, specify a valid option group ARN, for example <code>arn:aws:rds:us-west-2:123456789012:og:special-options</code>.</p> </li> </ul>"];
      target_option_group_identifier: String.t
        [@ocaml.doc
          "<p>The identifier for the copied option group.</p> <p>Constraints:</p> <ul> <li> <p>Can't be null, empty, or blank</p> </li> <li> <p>Must contain from 1 to 255 letters, numbers, or hyphens</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul> <p>Example: <code>my-option-group</code> </p>"];
      target_option_group_description: String.t
        [@ocaml.doc "<p>The description for the copied option group.</p>"];
      tags: TagList.t }[@@ocaml.doc "<p/>"]
    let make ~source_option_group_identifier  ~target_option_group_identifier
       ~target_option_group_description  ?(tags= [])  () =
      {
        source_option_group_identifier;
        target_option_group_identifier;
        target_option_group_description;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some
             ("target_option_group_description",
               (String.to_json v.target_option_group_description));
           Some
             ("target_option_group_identifier",
               (String.to_json v.target_option_group_identifier));
           Some
             ("source_option_group_identifier",
               (String.to_json v.source_option_group_identifier))])
    let parse xml =
      Some
        {
          source_option_group_identifier =
            (Xml.required "SourceOptionGroupIdentifier"
               (Util.option_bind
                  (Xml.member "SourceOptionGroupIdentifier" xml) String.parse));
          target_option_group_identifier =
            (Xml.required "TargetOptionGroupIdentifier"
               (Util.option_bind
                  (Xml.member "TargetOptionGroupIdentifier" xml) String.parse));
          target_option_group_description =
            (Xml.required "TargetOptionGroupDescription"
               (Util.option_bind
                  (Xml.member "TargetOptionGroupDescription" xml)
                  String.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "SourceOptionGroupIdentifier"
                    ([], (String.to_xml v.source_option_group_identifier)))])
             @
             [Some
                (Ezxmlm.make_tag "TargetOptionGroupIdentifier"
                   ([], (String.to_xml v.target_option_group_identifier)))])
            @
            [Some
               (Ezxmlm.make_tag "TargetOptionGroupDescription"
                  ([], (String.to_xml v.target_option_group_description)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc "<p/>"]
module CopyOptionGroupResult = CopyOptionGroupResult
type input = CopyOptionGroupMessage.t
type output = CopyOptionGroupResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CopyOptionGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CopyOptionGroupMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CopyOptionGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CopyOptionGroupResponse" (snd xml))
        (Xml.member "CopyOptionGroupResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CopyOptionGroupResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CopyOptionGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CopyOptionGroupResult - missing field in body or children: "
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