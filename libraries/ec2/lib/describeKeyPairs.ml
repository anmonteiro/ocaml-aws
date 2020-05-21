open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeKeyPairsRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>fingerprint</code> - The fingerprint of the key pair.</p> </li> <li> <p> <code>key-name</code> - The name of the key pair.</p> </li> </ul>"];
      key_names: KeyNameStringList.t
        [@ocaml.doc
          "<p>The key pair names.</p> <p>Default: Describes all your key pairs.</p>"];
      key_pair_ids: KeyPairIdStringList.t
        [@ocaml.doc "<p>The IDs of the key pairs.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?(filters= [])  ?(key_names= [])  ?(key_pair_ids= [])  ?dry_run 
      () = { filters; key_names; key_pair_ids; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("KeyPairId", (KeyPairIdStringList.to_query v.key_pair_ids)));
           Some
             (Query.Pair
                ("KeyName", (KeyNameStringList.to_query v.key_names)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("key_pair_ids", (KeyPairIdStringList.to_json v.key_pair_ids));
           Some ("key_names", (KeyNameStringList.to_json v.key_names));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          key_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "KeyName" xml)
                  KeyNameStringList.parse));
          key_pair_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "KeyPairId" xml)
                  KeyPairIdStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                 v.filters))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "KeyName"
                        ([], (KeyNameStringList.to_xml [x])))) v.key_names))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "KeyPairId"
                       ([], (KeyPairIdStringList.to_xml [x]))))
               v.key_pair_ids))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module DescribeKeyPairsResult = DescribeKeyPairsResult
type input = DescribeKeyPairsRequest.t
type output = DescribeKeyPairsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeKeyPairs"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeKeyPairsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeKeyPairsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeKeyPairsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeKeyPairsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DescribeKeyPairsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeKeyPairsResult - missing field in body or children: "
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