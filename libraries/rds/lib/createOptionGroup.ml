open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateOptionGroupMessage =
  struct
    type t =
      {
      option_group_name: String.t
        [@ocaml.doc
          "<p>Specifies the name of the option group to be created.</p> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 255 letters, numbers, or hyphens</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul> <p>Example: <code>myoptiongroup</code> </p>"];
      engine_name: String.t
        [@ocaml.doc
          "<p>Specifies the name of the engine that this option group should be associated with.</p>"];
      major_engine_version: String.t
        [@ocaml.doc
          "<p>Specifies the major version of the engine that this option group should be associated with.</p>"];
      option_group_description: String.t
        [@ocaml.doc "<p>The description of the option group.</p>"];
      tags: TagList.t
        [@ocaml.doc "<p>Tags to assign to the option group.</p>"]}[@@ocaml.doc
                                                                    "<p/>"]
    let make ~option_group_name  ~engine_name  ~major_engine_version 
      ~option_group_description  ?(tags= [])  () =
      {
        option_group_name;
        engine_name;
        major_engine_version;
        option_group_description;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some
             ("option_group_description",
               (String.to_json v.option_group_description));
           Some
             ("major_engine_version",
               (String.to_json v.major_engine_version));
           Some ("engine_name", (String.to_json v.engine_name));
           Some ("option_group_name", (String.to_json v.option_group_name))])
    let parse xml =
      Some
        {
          option_group_name =
            (Xml.required "OptionGroupName"
               (Util.option_bind (Xml.member "OptionGroupName" xml)
                  String.parse));
          engine_name =
            (Xml.required "EngineName"
               (Util.option_bind (Xml.member "EngineName" xml) String.parse));
          major_engine_version =
            (Xml.required "MajorEngineVersion"
               (Util.option_bind (Xml.member "MajorEngineVersion" xml)
                  String.parse));
          option_group_description =
            (Xml.required "OptionGroupDescription"
               (Util.option_bind (Xml.member "OptionGroupDescription" xml)
                  String.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "OptionGroupName"
                     ([], (String.to_xml v.option_group_name)))])
              @
              [Some
                 (Ezxmlm.make_tag "EngineName"
                    ([], (String.to_xml v.engine_name)))])
             @
             [Some
                (Ezxmlm.make_tag "MajorEngineVersion"
                   ([], (String.to_xml v.major_engine_version)))])
            @
            [Some
               (Ezxmlm.make_tag "OptionGroupDescription"
                  ([], (String.to_xml v.option_group_description)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc "<p/>"]
module CreateOptionGroupResult = CreateOptionGroupResult
type input = CreateOptionGroupMessage.t
type output = CreateOptionGroupResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CreateOptionGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateOptionGroupMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CreateOptionGroupMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateOptionGroupResponse" (snd xml))
        (Xml.member "CreateOptionGroupResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateOptionGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateOptionGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateOptionGroupResult - missing field in body or children: "
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