part of 'nft_bloc.dart';

class NftState extends Equatable {
  final Nft nft;

  NftState({
    required this.nft,
  });

  NftState copyWith({
    Nft? nft,
  }) {
    return NftState(
      nft: nft ?? this.nft,
    );
  }

  @override
  List<Object> get props => [nft];
}
