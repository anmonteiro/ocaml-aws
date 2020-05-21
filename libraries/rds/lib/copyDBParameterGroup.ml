open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CopyDBParameterGroupMessage =
  struct
    type t =
      {
      source_d_b_parameter_group_identifier: String.t
        [@ocaml.doc
          "<p> The identifier or ARN for the source DB parameter group. For information about creating an ARN, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.ARN.html#USER_Tagging.ARN.Constructing\"> Constructing an ARN for Amazon RDS</a> in the <i>Amazon RDS User Guide</i>. </p> <p>Constraints:</p> <ul> <li> <p>Must specify a valid DB parameter group.</p> </li> <li> <p>Must specify a valid DB parameter group identifier, for example <code>my-db-param-group</code>, or a valid ARN.</p> </li> </ul>"];
      target_d_b_parameter_group_identifier: String.t
        [@ocaml.doc
          "<p>The identifier for the copied DB parameter group.</p> <p>Constraints:</p> <ul> <li> <p>Can't be null, empty, or blank</p> </li> <li> <p>Must contain from 1 to 255 letters, numbers, or hyphens</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul> <p>Example: <code>my-db-parameter-group</code> </p>"];
      target_d_b_parameter_group_description: String.t
        [@ocaml.doc
          "<p>A description for the copied DB parameter group.</p>"];
      tags: TagList.t }[@@ocaml.doc "<p/>"]
    let make ~source_d_b_parameter_group_identifier 
      ~target_d_b_parameter_group_identifier 
      ~target_d_b_parameter_group_description  ?(tags= [])  () =
      {
        source_d_b_parameter_group_identifier;
        target_d_b_parameter_group_identifier;
        target_d_b_parameter_group_description;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some
             ("target_d_b_parameter_group_description",
               (String.to_json v.target_d_b_parameter_group_description));
           Some
             ("target_d_b_parameter_group_identifier",
               (String.to_json v.target_d_b_parameter_group_identifier));
           Some
             ("source_d_b_parameter_group_identifier",
               (String.to_json v.source_d_b_parameter_group_identifier))])
    let parse xml =
      Some
        {
          source_d_b_parameter_group_identifier =
            (Xml.required "SourceDBParameterGroupIdentifier"
               (Util.option_bind
                  (Xml.member "SourceDBParameterGroupIdentifier" xml)
                  String.parse));
          target_d_b_parameter_group_identifier =
            (Xml.required "TargetDBParameterGroupIdentifier"
               (Util.option_bind
                  (Xml.member "TargetDBParameterGroupIdentifier" xml)
                  String.parse));
          target_d_b_parameter_group_description =
            (Xml.required "TargetDBParameterGroupDescription"
               (Util.option_bind
                  (Xml.member "TargetDBParameterGroupDescription" xml)
                  String.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "SourceDBParameterGroupIdentifier"
                    ([],
                      (String.to_xml v.source_d_b_parameter_group_identifier)))])
             @
             [Some
                (Ezxmlm.make_tag "TargetDBParameterGroupIdentifier"
                   ([],
                     (String.to_xml v.target_d_b_parameter_group_identifier)))])
            @
            [Some
               (Ezxmlm.make_tag "TargetDBParameterGroupDescription"
                  ([],
                    (String.to_xml v.target_d_b_parameter_group_description)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc "<p/>"]
module CopyDBParameterGroupResult = CopyDBParameterGroupResult
type input = CopyDBParameterGroupMessage.t
type output = CopyDBParameterGroupResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CopyDBParameterGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CopyDBParameterGroupMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CopyDBParameterGroupMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CopyDBParameterGroupResponse" (snd xml))
        (Xml.member "CopyDBParameterGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CopyDBParameterGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CopyDBParameterGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CopyDBParameterGroupResult - missing field in body or children: "
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