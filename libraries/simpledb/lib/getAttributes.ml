open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetAttributesRequest =
  struct
    type t =
      {
      domain_name: String.t
        [@ocaml.doc
          "The name of the domain in which to perform the operation."];
      item_name: String.t [@ocaml.doc "The name of the item."];
      attribute_names: AttributeNameList.t
        [@ocaml.doc "The names of the attributes."];
      consistent_read: Boolean.t option
        [@ocaml.doc
          "Determines whether or not strong consistency should be enforced when data is read from SimpleDB. If <code>true</code>, any data previously written to SimpleDB will be returned. Otherwise, results will be consistent eventually, and the client may not see data that was written immediately before your read."]}
    let make ~domain_name  ~item_name  ?(attribute_names= []) 
      ?consistent_read  () =
      { domain_name; item_name; attribute_names; consistent_read }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.consistent_read
              (fun f -> ("consistent_read", (Boolean.to_json f)));
           Some
             ("attribute_names",
               (AttributeNameList.to_json v.attribute_names));
           Some ("item_name", (String.to_json v.item_name));
           Some ("domain_name", (String.to_json v.domain_name))])
    let parse xml =
      Some
        {
          domain_name =
            (Xml.required "DomainName"
               (Util.option_bind (Xml.member "DomainName" xml) String.parse));
          item_name =
            (Xml.required "ItemName"
               (Util.option_bind (Xml.member "ItemName" xml) String.parse));
          attribute_names = (Util.of_option [] (AttributeNameList.parse xml));
          consistent_read =
            (Util.option_bind (Xml.member "ConsistentRead" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DomainName"
                    ([], (String.to_xml v.domain_name)))])
             @
             [Some
                (Ezxmlm.make_tag "ItemName" ([], (String.to_xml v.item_name)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AttributeNames"
                       ([], (AttributeNameList.to_xml [x]))))
               v.attribute_names))
           @
           [Util.option_map v.consistent_read
              (fun f ->
                 Ezxmlm.make_tag "ConsistentRead" ([], (Boolean.to_xml f)))])
  end
module GetAttributesResult = GetAttributesResult
type input = GetAttributesRequest.t
type output = GetAttributesResult.t
type error = Errors_internal.t
let streaming = false
let service = "sdb"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2009-04-15"]); ("Action", ["GetAttributes"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetAttributesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (GetAttributesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "GetAttributesResponse" (snd xml))
        (Xml.member "GetAttributesResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetAttributesResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed GetAttributesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetAttributesResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors =
    [Errors_internal.NoSuchDomain;
    Errors_internal.MissingParameter;
    Errors_internal.InvalidParameterValue] @ Errors_internal.common in
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