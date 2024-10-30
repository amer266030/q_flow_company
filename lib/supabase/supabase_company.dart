import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:q_flow_company/mangers/data_mgr.dart';
import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/supabase/client/supabase_mgr.dart';
import 'package:q_flow_company/utils/img_converter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/social_links/social_link.dart';

class SupabaseCompany {
  static var supabase = SupabaseMgr.shared.supabase;
  static const String tableKey = 'company';
  static const String bucketKey = "company_logo";
  static final dataMgr = GetIt.I.get<DataMgr>();

  static Future<Company>? fetchCompany() async {
    var companyId = supabase.auth.currentUser?.id ?? '';
    try {
      // Fetch the visitor profile and associated social links based on user_id
      final response = await supabase
          .from(tableKey)
          .select('*, social_link(*)')
          .eq('id', companyId)
          .single();

      final company = Company.fromJson(response);

      dataMgr.saveCompanyData(company: company);

      if (response['social_link'] != null) {
        company.socialLinks = (response['social_link'] as List)
            .map((link) => SocialLink.fromJson(link))
            .toList();
      }

      return company;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future createCompany(
      {required Company company, required File? logoFile}) async {
    if (logoFile != null) {
      company.logoUrl = await uploadLogo(logoFile, company.name ?? '1234');
    }
    try {
      final response = await supabase.from(tableKey).insert(company.toJson());
      dataMgr.saveCompanyData(company: company);

      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future updateCompany(
      {required Company company,
      required String companyId,
      required File? imageFile}) async {
    if (imageFile != null) {
      company.logoUrl = await uploadLogo(imageFile, company.name ?? '1234');
    }
    try {
      final response = await supabase
          .from(tableKey)
          .update(company.toJson())
          .eq('id', companyId);
      dataMgr.saveCompanyData(company: company);
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> uploadLogo(File imageFile, String itemName) async {
    try {
      final fileBytes = await ImgConverter.fileImgToBytes(imageFile);
      final fileName = '$itemName.png';

      await supabase.storage.from(bucketKey).uploadBinary(fileName, fileBytes,
          fileOptions: const FileOptions(upsert: true));

      final publicUrl = supabase.storage.from(bucketKey).getPublicUrl(fileName);

      return publicUrl;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
