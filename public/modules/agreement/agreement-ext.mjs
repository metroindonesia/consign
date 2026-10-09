import Context from "./agreement-context.mjs";

const _agreement_id = "agreementHeaderEdit-obj_agreement_id";
const _iscommit = "agreementHeaderEdit-obj_iscommit";
const _isapprove = "agreementHeaderEdit-obj_isapprove";
const _datestart = "agreementHeaderEdit-obj_agreement_datestart";
const _dateend = "agreementHeaderEdit-obj_agreement_dateend";
const _adendum_id = "agreementHeaderEdit-obj_adendum_id";
const _adendum_seq = "agreementHeaderEdit-obj_adendum_seq";

export const extenderHeader = null;

export const extenderBrand = {
  obj_brand_id_selecting_criteria(self, obj_brand_id, frm, criteria, sort, evt) {
    criteria.brand_isdisabled = false;
    const frmHeader = evt.detail.CurrentState.getHeaderForm();
    const partner_id = frmHeader.Inputs['agreementHeaderEdit-obj_partner_id']?.value;
    if (partner_id) {
      criteria.partner_id = partner_id;
    }
  }
};
export const extenderMargin = {
  obj_marginrange_id_selected(self, obj_marginrange_id, frm, evt) {
    // Data objek dari opsi marginrange yang dipilih
    const item = evt.detail.selectedData || evt.detail.row || evt.detail.data;
    if (item) {
      // Ambil input marginrange_start & marginrange_end dari Form
      const obj_marginrange_start =
        frm.Inputs["agreementMarginEdit-obj_marginrange_start"];
      const obj_marginrange_end =
        frm.Inputs["agreementMarginEdit-obj_marginrange_end"];

      if (obj_marginrange_start)
        obj_marginrange_start.value = item.marginrange_start;
      if (obj_marginrange_end) obj_marginrange_end.value = item.marginrange_end;
    }
  },
};

// Top-level export - dipanggil oleh FGTA5 karena extenderHeader = null
export function obj_partner_id_selecting_criteria(self, obj_partner_id, frm, criteria, sort, evt) {
  criteria.partner_isdisabled = false;
}

export function obj_site_id_selecting_criteria(self, obj_site_id, frm, criteria, sort, evt) {
  criteria.site_isdisabled = false;
}

const VIEW_VARIANCE = "view";

export async function init(self, args) {
  console.log("initializing agreementExtender ...");

  // tambahkan extender inisiasi module agreement
  const recordbar = document.getElementById(
    "agreementHeader-btn_about",
  ).parentElement;

  if (document.getElementById("agreementHeader-btn_print")) return;

  const element = document.createElement("button");
  element.id = "agreementHeader-btn_print";
  element.innerHTML = `
  <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
        stroke="currentColor" stroke-width="2" stroke-linecap="round"
        stroke-linejoin="round" aria-hidden="true">
        <polyline points="6 9 6 2 18 2 18 9"></polyline>
        <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path>
        <rect x="6" y="14" width="12" height="8"></rect>
      </svg>
    <span>Print</span>
  `;

  recordbar.appendChild(element);

  const btn_print = new $fgta5.ActionButton("agreementHeader-btn_print");
  btn_print.addEventListener("click", () => {
    let agreement_id = null;

    const frm = self.Modules.agreementHeaderEdit?.getForm?.(self);
    if (frm?.Inputs?.[_agreement_id]?.value) {
      agreement_id = frm.Inputs[_agreement_id].value;
    }

    if (!agreement_id) {
      const el = document.getElementById(
        "agreementHeaderEdit-obj_agreement_id",
      );
      if (el && el.value) {
        agreement_id = el.value;
      }
    }

    if (!agreement_id) {
      const selectedRow =
        self.Modules.agreementHeaderList?.getCurrentRow?.(self);
      if (selectedRow) {
        const grid = self.Modules.agreementHeaderList?.getGrid?.(self);
        const rowData = grid?.getRowData
          ? grid.getRowData(selectedRow)
          : selectedRow.data;
        agreement_id =
          rowData?.agreement_id || selectedRow.getAttribute?.("data-id");
      }
    }

    const printArea = document.getElementById("print-area");

    if (agreement_id && printArea) {
      printDocument(self, printArea, agreement_id);
    }
  });
}

export async function printDocument(self, printArea, agreement_id) {
  // console.log(`print ${agreement_id}`);

  let mask = $fgta5.Modal.createMask();
  const printContainer = document.getElementById("print-media-container");

  try {
    mask.setText("preparing document...");
    const currentUrl = import.meta.url;
    const directory = new URL(".", currentUrl).href;
    const fileUrl = new URL("agreement-print.html", directory).href;
    const response = await fetch(fileUrl);
    printArea.innerHTML = await response.text();

    const docTitle = document.getElementById("doc-title");

    mask.setText("preparing document...");
    const url = "agreement/execute";
    const data = await Module.apiCall(url, {
      fnName: "getPrintData",
      agreement_id: agreement_id,
    });

    if (docTitle && data.title) docTitle.innerHTML = data.title;

    await renderData(data, printArea);

    if (printContainer) printContainer.classList.remove("hidden");

    mask.close();
    mask = null;

    setTimeout(() => {
      window.print();
    }, 200);
  } catch (err) {
    console.error(err);
    $fgta5.MessageBox.error(err.message);
  } finally {
    if (mask) {
      mask.close();
      mask = null;
    }
  }
}

async function renderData(data) {
  let headerHtml;
  let footerHtml;

  const docHeader = document.getElementById("doc-header");
  const docFooter = document.getElementById("doc-footer");
  if (docHeader) headerHtml = docHeader.innerHTML;
  if (docFooter) footerHtml = docFooter.innerHTML;

  for (const key in data.header) {
    const varPlaceholder = new RegExp(`{{\\s*${key}\\s*}}`, "g");
    let value = data.header[key] ?? "";
    if (docHeader) headerHtml = headerHtml.replace(varPlaceholder, value);
    if (docFooter) footerHtml = footerHtml.replace(varPlaceholder, value);
  }

  if (docHeader) docHeader.innerHTML = headerHtml;
  if (docFooter) docFooter.innerHTML = footerHtml;

  const noRow = document.getElementById("doc-brand-no");
  const brandRow = document.getElementById("doc-brand-name");

  if (noRow && brandRow && Array.isArray(data.detilBrand)) {
    const templateNoCell = noRow.querySelector(".brand-no-val");
    const templateBrandCell = brandRow.querySelector(".brand-name-val");

    if (templateNoCell && templateBrandCell) {
      noRow.querySelectorAll("td").forEach((el) => el.remove());
      brandRow.querySelectorAll("td").forEach((el) => el.remove());

      data.detilBrand.forEach((row, index) => {
        const noCell = templateNoCell.cloneNode(true);
        noCell.textContent = row.no ?? (index + 1);
        noRow.appendChild(noCell);

        const brandCell = templateBrandCell.cloneNode(true);
        brandCell.textContent = row.brand_name ?? "-";
        brandRow.appendChild(brandCell);
      });
    }
  }

  // Render Tabel Margin (#doc-margin-body)
  const docMarginBody = document.getElementById("doc-margin-body");
  if (docMarginBody && Array.isArray(data.detilMargin)) {
    const rowTemplate = docMarginBody.innerHTML;
    docMarginBody.innerHTML = "";
    for (const row of data.detilMargin) {
      let renderedHtml = rowTemplate;
      for (const key in row) {
        const varPlaceholder = new RegExp(`{{\\s*${key}\\s*}}`, "g");
        renderedHtml = renderedHtml.replace(varPlaceholder, row[key] ?? "");
      }
      docMarginBody.insertAdjacentHTML("beforeend", renderedHtml);
    }
  }

  const docDocBody = document.getElementById("doc-doc-body");
  if (docDocBody && Array.isArray(data.detilDoc)) {
    const rowTemplate = docDocBody.innerHTML;
    docDocBody.innerHTML = "";
    for (const row of data.detilDoc) {
      let renderedHtml = rowTemplate;
      for (const key in row) {
        const varPlaceholder = new RegExp(`{{\\s*${key}\\s*}}`, "g");
        renderedHtml = renderedHtml.replace(varPlaceholder, row[key] ?? "");
      }
      docDocBody.insertAdjacentHTML("beforeend", renderedHtml);
    }
  }
}

export function setupActionButtonEvent(self, frm, CurrentState, buttons) {
  const onView = Context.variance == VIEW_VARIANCE;
  CurrentState.Actions.newdata.suspend(onView);
  CurrentState.Actions.edit.suspend(onView);

  CurrentState.Actions.commit.addEventListener("click", (evt) => {
    btnCommit_onClick(self, frm, CurrentState, buttons, evt);
  });

  CurrentState.Actions.uncommit.addEventListener("click", (evt) => {
    btnUncommit_onClick(self, frm, CurrentState, buttons, evt);
  });

  CurrentState.Actions.approve.addEventListener("click", (evt) => {
    btnApprove_onClick(self, frm, CurrentState, buttons, evt);
  });

  CurrentState.Actions.unapprove.addEventListener("click", (evt) => {
    btnUnapprove_onClick(self, frm, CurrentState, buttons, evt);
  });
}

export async function agreementHeaderEdit_formOpened(self, frm, CurrentState) {
  const data = frm.getOriginalData();

  const commitby = document.getElementById("fRecord-section-commitby");
  const commitdate = document.getElementById("fRecord-section-commitdate");
  const approveby = document.getElementById("fRecord-section-approveby");
  const approvedate = document.getElementById("fRecord-section-approvedate");

  commitby.innerHTML = data.commitby;
  commitdate.innerHTML = data.commitdate;
  approveby.innerHTML = data.approveby;
  approvedate.innerHTML = data.approvedate;

  updateStatusButton(self, frm, CurrentState);
}

async function updateStatusButton(self, frm, CurrentState, buttons, evt) {
  const iscommit = frm.Inputs[_iscommit].value;
  const isapprove = frm.Inputs[_isapprove].value;

  CurrentState.Actions.commit.suspend(iscommit);
  CurrentState.Actions.uncommit.suspend(!iscommit || isapprove);
  CurrentState.Actions.approve.suspend(isapprove || !iscommit);
  CurrentState.Actions.unapprove.suspend(!isapprove);
  CurrentState.Actions.edit.suspend(isapprove)
}

async function btnCommit_onClick(self, frm, CurrentState, buttons, evt) {
  // console.log("commit geys")
  const agreement_id = frm.Inputs[_agreement_id].value;
  // console.log(agreement_id);

  try {
    const url = "agreement/execute";
    const result = await Module.apiCall(url, {
      fnName: "commit",
      agreement_id: agreement_id,
      iscommit: true,
    });

    frm.Inputs[_iscommit].value = true;
    frm.acceptChanges();
    updateStatusButton(self, frm, CurrentState, buttons, evt);
    $fgta5.MessageBox.info("Agreement berhasil dicommit");
  } catch (err) {
    console.error(err);
    $fgta5.MessageBox.error(err.message);
  }
}

async function btnUncommit_onClick(self, frm, CurrentState, buttons, evt) {
  // console.log("commit geys")
  const agreement_id = frm.Inputs[_agreement_id].value;
  // console.log(agreement_id);

  try {
    const url = "agreement/execute";
    const result = await Module.apiCall(url, {
      fnName: "uncommit",
      agreement_id: agreement_id,
      iscommit: false,
    });

    frm.Inputs[_iscommit].value = false;
    frm.acceptChanges();
    updateStatusButton(self, frm, CurrentState, buttons, evt);
    $fgta5.MessageBox.info("Agreement berhasil diuncommit");
  } catch (err) {
    console.error(err);
    $fgta5.MessageBox.error(err.message);
  }
}

async function btnApprove_onClick(self, frm, CurrentState, buttons, evt) {
  // console.log("approve geys")
  const agreement_id = frm.Inputs[_agreement_id].value;

  try {
    const url = "agreement/execute";
    const result = await Module.apiCall(url, {
      fnName: "approve",
      agreement_id: agreement_id,
      isapprove: true,
    });

    frm.Inputs[_isapprove].value = true;
    frm.acceptChanges();
    updateStatusButton(self, frm, CurrentState, buttons, evt);
    $fgta5.MessageBox.info("Agreement berhasil diapprove");
  } catch (err) {
    console.error(err);
    $fgta5.MessageBox.error(err.message);
  }
}

async function btnUnapprove_onClick(self, frm, CurrentState, buttons, evt) {
  // console.log("unapprove geys")
  const agreement_id = frm.Inputs[_agreement_id].value;

  try {
    const url = "agreement/execute";
    const result = await Module.apiCall(url, {
      fnName: "unapprove",
      agreement_id: agreement_id,
      isapprove: false,
    });

    frm.Inputs[_isapprove].value = false;
    frm.acceptChanges();
    updateStatusButton(self, frm, CurrentState, buttons, evt);
    $fgta5.MessageBox.info("Agreement berhasil diunapprove");
  } catch (err) {
    console.error(err);
    $fgta5.MessageBox.error(err.message);
  }
}

export async function agreementHeaderEdit_dataSaving(
  self,
  dataToSave,
  frm,
  args,
) {
  const startDate = frm.Inputs[_datestart].value;
  const endDate = frm.Inputs[_dateend].value;

  if (startDate > endDate) {
    args.cancelSave = true;
    $fgta5.MessageBox.error("startDate tidak boleh lebih besar dari endDate");
  }
}
