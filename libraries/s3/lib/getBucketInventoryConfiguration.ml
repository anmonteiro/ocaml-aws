open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetBucketInventoryConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The name of the bucket containing the inventory configuration to retrieve.</p>"];
      id: String.t
        [@ocaml.doc
          "<p>The ID used to identify the inventory configuration.</p>"]}
    let make ~bucket  ~id  () = { bucket; id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
  end
module GetBucketInventoryConfigurationOutput =
  GetBucketInventoryConfigurationOutput
type input = GetBucketInventoryConfigurationRequest.t
type output = GetBucketInventoryConfigurationOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.GetBucketInventoryConfigurationRequest.bucket) ^
               "?inventory")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (GetBucketInventoryConfigurationRequest.to_query req)))) in
  (`GET, uri,
    (Headers.render (GetBucketInventoryConfigurationRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  match let ((`String body) :
          [ `String of string  | `Streaming of Piaf.Body.t ]) = body[@@ocaml.warning
                                                                    "-8"] in
        try
          let xml = Ezxmlm.from_string body in
          let resp =
            match List.hd (snd xml) with
            | `El (_, xs) -> Some xs
            | _ ->
                raise
                  (Failure
                     "Could not find well formed InventoryConfiguration.") in
          try
            let open Error in
              Util.or_error
                (Util.option_bind resp InventoryConfiguration.parse)
                (BadResponse
                   {
                     body;
                     message =
                       "Could not find well formed InventoryConfiguration."
                   })
          with
          | Xml.RequiredFieldMissing msg ->
              let open Error in
                `Error
                  (BadResponse
                     {
                       body;
                       message =
                         ("Error parsing InventoryConfiguration - missing field in body or children: "
                            ^ msg)
                     })
        with
        | Failure msg ->
            let open Error in
              `Error
                (BadResponse
                   { body; message = ("Error parsing xml: " ^ msg) })
  with
  | `Ok payload ->
      `Ok (GetBucketInventoryConfigurationOutput.of_headers headers payload)
  | `Error err -> `Error err
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