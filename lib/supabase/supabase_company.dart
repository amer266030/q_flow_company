import 'dart:io';

import 'package:q_flow_company/model/user/company.dart';
import 'package:q_flow_company/supabase/supabase_mgr.dart';
import 'package:q_flow_company/utils/img_converter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCompany {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'company';
  static final String bucketKey = "company_logo";
  static Future<List<Company>>? fetchCompany() async {
    try {
      var res = await supabase.from(tableKey).select();
      List<Company> companies = (res as List)
          .map((company) => Company.fromJson(company as Map<String, dynamic>))
          .toList();
      return companies;
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
    try {
      if (logoFile != null) {
        company.logoUrl = await uploadLogo(logoFile, company.name ?? '1234');
      }
      final response = await supabase
          .from(tableKey)
          .insert(company.toJson())
          .select()
          .single();
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future updateCompany( {required Company company,
      required String companyId,
      required File? imageFile}) async {
        
    try {
       if (imageFile != null) {
        company.logoUrl = await uploadLogo(imageFile, company.name ?? '1234');
      }
      final response = await supabase
          .from(tableKey)
          .update(company.toJson())
          .eq('id', companyId);
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
          fileOptions: FileOptions(upsert: true));

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

  static Future<bool> doesCompanyExist(Company company) async {
    try {
      final response = await Supabase.instance.client
          .from(tableKey)
          .select()
          .eq('id', company.id ?? '')
          .single();

      return response != null;
    } on PostgrestException catch (e) {
      throw Exception('Error checking company existence: ${e.message}');
    } catch (e) {
      throw Exception(
          'Unknown error occurred while checking company existence: $e');
    }
  }
}
