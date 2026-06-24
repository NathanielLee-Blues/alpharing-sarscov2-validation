#!/usr/bin/env python3
"""Parse amino-acid substitution labels from the final AlphaRING dataset.

Example:
    N61H -> wild_type=N, position=61, mutant=H

Run from repository root:
    python scripts/variant_parser.py data/processed/Final_AlphaRING_for_classification.xlsx results/tables/parsed_variants.csv
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

import pandas as pd

VARIANT_PATTERN = re.compile(r"^([A-Z])([0-9]+)([A-Z])$")


def parse_variant(variant: str) -> tuple[str | None, int | None, str | None]:
    """Return wild-type residue, position, and mutant residue from a variant label."""
    if not isinstance(variant, str):
        return None, None, None
    match = VARIANT_PATTERN.match(variant.strip())
    if not match:
        return None, None, None
    wt, pos, mut = match.groups()
    return wt, int(pos), mut


def main() -> None:
    parser = argparse.ArgumentParser(description="Parse amino-acid substitution labels from AlphaRING spreadsheet.")
    parser.add_argument("input_xlsx", type=Path, help="Input Excel file")
    parser.add_argument("output_csv", type=Path, help="Output CSV file")
    parser.add_argument("--sheet", default="AlphaRING_with_annotations", help="Excel sheet name")
    args = parser.parse_args()

    df = pd.read_excel(args.input_xlsx, sheet_name=args.sheet)

    source_col = "Simplified" if "Simplified" in df.columns else "Substitution"
    parsed = df[source_col].apply(parse_variant)

    df["wild_type_residue"] = [x[0] for x in parsed]
    df["variant_position"] = [x[1] for x in parsed]
    df["mutant_residue"] = [x[2] for x in parsed]

    args.output_csv.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(args.output_csv, index=False)

    total = len(df)
    parsed_count = df["variant_position"].notna().sum()
    print(f"Parsed {parsed_count}/{total} variants from column '{source_col}'.")
    print(f"Saved: {args.output_csv}")


if __name__ == "__main__":
    main()
