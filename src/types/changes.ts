import { source } from "@/lib/source"

export type CustomPage = ReturnType<typeof source.getPage> & {
  data: {
    changeLog: Change[]
  }
}

export type Change = {
  date: Date,
  author: string,
  changes: string[]
}