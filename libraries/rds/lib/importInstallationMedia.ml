open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ImportInstallationMediaMessage =
  struct
    type t =
      {
      custom_availability_zone_id: String.t
        [@ocaml.doc
          "<p>The identifier of the custom Availability Zone (AZ) to import the installation media to.</p>"];
      engine: String.t
        [@ocaml.doc
          "<p>The name of the database engine to be used for this instance. </p> <p>The list only includes supported DB engines that require an on-premises customer provided license. </p> <p>Valid Values: </p> <ul> <li> <p> <code>sqlserver-ee</code> </p> </li> <li> <p> <code>sqlserver-se</code> </p> </li> <li> <p> <code>sqlserver-ex</code> </p> </li> <li> <p> <code>sqlserver-web</code> </p> </li> </ul>"];
      engine_version: String.t
        [@ocaml.doc
          "<p>The version number of the database engine to use.</p> <p>For a list of valid engine versions, call <a>DescribeDBEngineVersions</a>.</p> <p>The following are the database engines and links to information about the major and minor versions. The list only includes DB engines that require an on-premises customer provided license.</p> <p> <b>Microsoft SQL Server</b> </p> <p>See <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.FeatureSupport\">Version and Feature Support on Amazon RDS</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      engine_installation_media_path: String.t
        [@ocaml.doc
          "<p>The path to the installation medium for the specified DB engine.</p> <p>Example: <code>SQLServerISO/en_sql_server_2016_enterprise_x64_dvd_8701793.iso</code> </p>"];
      o_s_installation_media_path: String.t
        [@ocaml.doc
          "<p>The path to the installation medium for the operating system associated with the specified DB engine.</p> <p>Example: <code>WindowsISO/en_windows_server_2016_x64_dvd_9327751.iso</code> </p>"]}
    let make ~custom_availability_zone_id  ~engine  ~engine_version 
      ~engine_installation_media_path  ~o_s_installation_media_path  () =
      {
        custom_availability_zone_id;
        engine;
        engine_version;
        engine_installation_media_path;
        o_s_installation_media_path
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("o_s_installation_media_path",
                (String.to_json v.o_s_installation_media_path));
           Some
             ("engine_installation_media_path",
               (String.to_json v.engine_installation_media_path));
           Some ("engine_version", (String.to_json v.engine_version));
           Some ("engine", (String.to_json v.engine));
           Some
             ("custom_availability_zone_id",
               (String.to_json v.custom_availability_zone_id))])
    let parse xml =
      Some
        {
          custom_availability_zone_id =
            (Xml.required "CustomAvailabilityZoneId"
               (Util.option_bind (Xml.member "CustomAvailabilityZoneId" xml)
                  String.parse));
          engine =
            (Xml.required "Engine"
               (Util.option_bind (Xml.member "Engine" xml) String.parse));
          engine_version =
            (Xml.required "EngineVersion"
               (Util.option_bind (Xml.member "EngineVersion" xml)
                  String.parse));
          engine_installation_media_path =
            (Xml.required "EngineInstallationMediaPath"
               (Util.option_bind
                  (Xml.member "EngineInstallationMediaPath" xml) String.parse));
          o_s_installation_media_path =
            (Xml.required "OSInstallationMediaPath"
               (Util.option_bind (Xml.member "OSInstallationMediaPath" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "CustomAvailabilityZoneId"
                     ([], (String.to_xml v.custom_availability_zone_id)))])
              @
              [Some (Ezxmlm.make_tag "Engine" ([], (String.to_xml v.engine)))])
             @
             [Some
                (Ezxmlm.make_tag "EngineVersion"
                   ([], (String.to_xml v.engine_version)))])
            @
            [Some
               (Ezxmlm.make_tag "EngineInstallationMediaPath"
                  ([], (String.to_xml v.engine_installation_media_path)))])
           @
           [Some
              (Ezxmlm.make_tag "OSInstallationMediaPath"
                 ([], (String.to_xml v.o_s_installation_media_path)))])
  end
module InstallationMedia = InstallationMedia
type input = ImportInstallationMediaMessage.t
type output = InstallationMedia.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["ImportInstallationMedia"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ImportInstallationMediaMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ImportInstallationMediaMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ImportInstallationMediaResponse" (snd xml))
        (Xml.member "ImportInstallationMediaResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp InstallationMedia.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed InstallationMedia."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing InstallationMedia - missing field in body or children: "
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